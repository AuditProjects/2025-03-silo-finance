// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity 0.8.28;

import {IERC4626} from "openzeppelin5/interfaces/IERC4626.sol";
import {UtilsLib} from "morpho-blue/libraries/UtilsLib.sol";

import {RevertLib} from "silo-core/contracts/lib/RevertLib.sol";

import {
    FlowCaps,
    FlowCapsConfig,
    Withdrawal,
    MAX_SETTABLE_FLOW_CAP,
    IPublicAllocatorStaticTyping,
    IPublicAllocatorBase
} from "./interfaces/IPublicAllocator.sol";
import {ISiloVault, MarketAllocation} from "./interfaces/ISiloVault.sol";

import {ErrorsLib} from "./libraries/ErrorsLib.sol";
import {EventsLib} from "./libraries/EventsLib.sol";

/// @title PublicAllocator
/// @author Forked with gratitude from Morpho Labs.
/// @custom:contact security@morpho.org
/// @notice Publicly callable allocator for SiloVault vaults.
// 管理某个 SiloVault 的分配权限与费用等参数
contract PublicAllocator is IPublicAllocatorStaticTyping {
    using UtilsLib for uint256;

    /* STORAGE */
    // @? 很多SiloVault?
    /// @inheritdoc IPublicAllocatorBase
    mapping(ISiloVault => address) public admin;
    /// @inheritdoc IPublicAllocatorBase
    mapping(ISiloVault => uint256) public fee;
    /// @inheritdoc IPublicAllocatorBase
    mapping(ISiloVault => uint256) public accruedFee;
    /// @inheritdoc IPublicAllocatorStaticTyping
    mapping(ISiloVault => mapping(IERC4626 => FlowCaps)) public flowCaps; // 限制每个市场每次 reallocate 的最大流入/流出量

    /* MODIFIER */

    /// @dev Reverts if the caller is not the admin nor the owner of this vault.
    modifier onlyAdminOrVaultOwner(ISiloVault vault) {
        // @q-a 权限有无问题 - no
        if (msg.sender != admin[vault] && msg.sender != ISiloVault(vault).owner()) {
            revert ErrorsLib.NotAdminNorVaultOwner();
        }
        _;
    }

    /* ADMIN OR VAULT OWNER ONLY */

    /// @inheritdoc IPublicAllocatorBase
    function setAdmin(ISiloVault vault, address newAdmin) external virtual onlyAdminOrVaultOwner(vault) {
        if (admin[vault] == newAdmin) revert ErrorsLib.AlreadySet();
        admin[vault] = newAdmin;
        emit EventsLib.SetAdmin(msg.sender, vault, newAdmin);
    }

    /// @inheritdoc IPublicAllocatorBase
    function setFee(ISiloVault vault, uint256 newFee) external virtual onlyAdminOrVaultOwner(vault) {
        if (fee[vault] == newFee) revert ErrorsLib.AlreadySet();
        fee[vault] = newFee;
        emit EventsLib.SetFee(msg.sender, vault, newFee);
    }

    /// @inheritdoc IPublicAllocatorBase
    function setFlowCaps(
        ISiloVault vault,
        FlowCapsConfig[] calldata config
    ) external virtual onlyAdminOrVaultOwner(vault) {
        // @q-a for loop - 无碍
        for (uint256 i = 0; i < config.length; i++) {
            FlowCapsConfig memory cfg = config[i];
            IERC4626 market = cfg.market;

            if (!vault.config(market).enabled && (cfg.caps.maxIn > 0 || cfg.caps.maxOut > 0)) {
                revert ErrorsLib.MarketNotEnabled(market);
            }
            if (cfg.caps.maxIn > MAX_SETTABLE_FLOW_CAP || cfg.caps.maxOut > MAX_SETTABLE_FLOW_CAP) {
                revert ErrorsLib.MaxSettableFlowCapExceeded();
            }

            flowCaps[vault][market] = cfg.caps;
        }

        emit EventsLib.SetFlowCaps(msg.sender, vault, config);
    }

    /// @inheritdoc IPublicAllocatorBase
    // @q-a 可以自行构造vault,但是没有相应记录
    function transferFee(ISiloVault vault, address payable feeRecipient) external virtual onlyAdminOrVaultOwner(vault) {
        uint256 claimed = accruedFee[vault];
        accruedFee[vault] = 0;
        // @q-a 地址检查, 重入? - 管理员不作恶
        (bool success, bytes memory data) = feeRecipient.call{value: claimed}("");
        if (!success) RevertLib.revertBytes(data, "fee transfer failed");

        emit EventsLib.TransferFee(msg.sender, vault, claimed, feeRecipient);
    }

    /* PUBLIC */

    /// @inheritdoc IPublicAllocatorBase
    // 任何人都能调用 reallocateTo发起迁移
    // @q-a 任何人执行,获得什么好处 - 1.事件记录 2. 调用者为LP
    function reallocateTo(
        ISiloVault vault, // @q-a 自行构造一个vault能否改变状态 -只会改变该vault对应的
        Withdrawal[] calldata withdrawals, // 指定vault撤出多少资产
        IERC4626 supplyMarket // 目标市场, 将撤出资产投入
    ) external payable virtual {
        // @q-a 为什么需要费用? 传入数量为何一定要相等? - 设计费用
        if (msg.value != fee[vault]) revert ErrorsLib.IncorrectFee();
        if (msg.value > 0) accruedFee[vault] += msg.value;

        // @q 没有进行足够的检查,可以直接调用 vault.reallocate. 能否绕过检测改变状态
        if (withdrawals.length == 0) revert ErrorsLib.EmptyWithdrawals();
        // 未开启
        if (!vault.config(supplyMarket).enabled) revert ErrorsLib.MarketNotEnabled(supplyMarket);

        MarketAllocation[] memory allocations = new MarketAllocation[](withdrawals.length + 1);
        uint128 totalWithdrawn;

        IERC4626 market;
        IERC4626 prevMarket;

        for (uint256 i = 0; i < withdrawals.length; i++) {
            prevMarket = market;
            Withdrawal memory withdrawal = withdrawals[i];
            market = withdrawal.market;

            if (!vault.config(market).enabled) revert ErrorsLib.MarketNotEnabled(market);
            if (withdrawal.amount == 0) revert ErrorsLib.WithdrawZero(market);
            // 数组中每个 market 的地址必须严格递增
            if (address(market) <= address(prevMarket)) revert ErrorsLib.InconsistentWithdrawals();
            if (address(market) == address(supplyMarket)) revert ErrorsLib.DepositMarketInWithdrawals();
            // market中vault持有所有资产
            uint256 assets = _expectedSupplyAssets(market, address(vault));

            if (flowCaps[vault][market].maxOut < withdrawal.amount) revert ErrorsLib.MaxOutflowExceeded(market);
            if (assets < withdrawal.amount) revert ErrorsLib.NotEnoughSupply(market);

            flowCaps[vault][market].maxIn += withdrawal.amount;
            flowCaps[vault][market].maxOut -= withdrawal.amount;
            //
            allocations[i].market = market;
            allocations[i].assets = assets - withdrawal.amount; // 更新

            totalWithdrawn += withdrawal.amount;

            emit EventsLib.PublicWithdrawal(msg.sender, vault, market, withdrawal.amount);
        }

        if (flowCaps[vault][supplyMarket].maxIn < totalWithdrawn) revert ErrorsLib.MaxInflowExceeded(supplyMarket);

        flowCaps[vault][supplyMarket].maxIn -= totalWithdrawn;
        flowCaps[vault][supplyMarket].maxOut += totalWithdrawn;
        allocations[withdrawals.length].market = supplyMarket;
        allocations[withdrawals.length].assets = type(uint256).max;
        // 执行 siloVault reallocate
        vault.reallocate(allocations);

        emit EventsLib.PublicReallocateTo(msg.sender, vault, supplyMarket, totalWithdrawn);
    }

    /// @notice Returns the expected supply assets balance of `user` on a market after having accrued interest.
    function _expectedSupplyAssets(IERC4626 _market, address _user) internal view virtual returns (uint256 assets) {
        assets = _market.convertToAssets(_market.balanceOf(_user));
    }
}
