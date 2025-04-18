// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity 0.8.28;

import {SafeCast} from "openzeppelin5/utils/math/SafeCast.sol";
import {ERC4626, Math} from "openzeppelin5/token/ERC20/extensions/ERC4626.sol";
import {IERC4626, IERC20, IERC20Metadata} from "openzeppelin5/interfaces/IERC4626.sol";
import {Ownable2Step, Ownable} from "openzeppelin5/access/Ownable2Step.sol";
import {ERC20Permit} from "openzeppelin5/token/ERC20/extensions/ERC20Permit.sol";
import {Multicall} from "openzeppelin5/utils/Multicall.sol";
import {ERC20} from "openzeppelin5/token/ERC20/ERC20.sol";
import {SafeERC20} from "openzeppelin5/token/ERC20/utils/SafeERC20.sol";
import {UtilsLib} from "morpho-blue/libraries/UtilsLib.sol";

import {TokenHelper} from "silo-core/contracts/lib/TokenHelper.sol";

import {MarketConfig, PendingUint192, PendingAddress, MarketAllocation, ISiloVaultBase, ISiloVaultStaticTyping, ISiloVault} from "./interfaces/ISiloVault.sol";

import {INotificationReceiver} from "./interfaces/INotificationReceiver.sol";
import {IVaultIncentivesModule} from "./interfaces/IVaultIncentivesModule.sol";
import {IIncentivesClaimingLogic} from "./interfaces/IIncentivesClaimingLogic.sol";

import {PendingUint192, PendingAddress, PendingLib} from "./libraries/PendingLib.sol";
import {ConstantsLib} from "./libraries/ConstantsLib.sol";
import {ErrorsLib} from "./libraries/ErrorsLib.sol";
import {EventsLib} from "./libraries/EventsLib.sol";
import {SiloVaultActionsLib} from "./libraries/SiloVaultActionsLib.sol";

/// @title SiloVault
/// @dev Forked with gratitude from Morpho Labs.
/// @author Silo Labs
/// @custom:contact security@silo.finance
/// @notice ERC4626 compliant vault allowing users to deposit assets to any ERC4626 vault.
contract SiloVault is ERC4626, ERC20Permit, Ownable2Step, Multicall, ISiloVaultStaticTyping {
    uint256 constant WAD = 1e18;

    using Math for uint256;
    using SafeERC20 for IERC20;
    using PendingLib for PendingUint192;
    using PendingLib for PendingAddress;

    /* IMMUTABLES */

    /// @notice OpenZeppelin decimals offset used by the ERC4626 implementation.
    /// @dev Calculated to be max(0, 18 - underlyingDecimals) at construction, so the initial conversion rate maximizes
    /// precision between shares and assets.
    uint8 public immutable DECIMALS_OFFSET;

    IVaultIncentivesModule public immutable INCENTIVES_MODULE;

    /* STORAGE */

    /// @inheritdoc ISiloVaultBase
    address public curator;

    /// @inheritdoc ISiloVaultBase
    mapping(address => bool) public isAllocator;

    /// @inheritdoc ISiloVaultBase
    address public guardian;

    /// @inheritdoc ISiloVaultStaticTyping
    mapping(IERC4626 => MarketConfig) public config;

    /// @inheritdoc ISiloVaultBase
    // 时间锁只显示设置关键参数,而不是用户存提款
    uint256 public timelock; // 将时间添加到对应 pending 结构上

    /// @inheritdoc ISiloVaultStaticTyping
    PendingAddress public pendingGuardian;

    /// @inheritdoc ISiloVaultStaticTyping
    mapping(IERC4626 => PendingUint192) public pendingCap;

    /// @inheritdoc ISiloVaultStaticTyping
    PendingUint192 public pendingTimelock; // 设置timelock时的 pending

    /// @dev Internal balance tracker to prevent assets loss if underlying market hacked
    /// and started reporting wrong supply.
    /// max loss == supplyCap + arbitraryLossThreshold * N deposits + un accrued interest.
    /// Un accrued interest loss present only if it is less than balanceTracker[market] - supplyAssets.
    /// But this is only about internal balances. There is no interest loss on the vault.
    mapping(IERC4626 => uint256) public balanceTracker;

    /// @inheritdoc ISiloVaultBase
    uint96 public fee;

    /// @inheritdoc ISiloVaultBase
    address public feeRecipient;

    /// @inheritdoc ISiloVaultBase
    // 优先注资/提资的 vault 列表
    // @q 如果 supplyQueue, withdrawQueue 由管理者添加恶意非标准ERC4626,则无法正常withdraw?
    IERC4626[] public supplyQueue;

    /// @inheritdoc ISiloVaultBase
    IERC4626[] public withdrawQueue;

    /// @inheritdoc ISiloVaultBase
    uint256 public lastTotalAssets;

    bool transient _lock;

    /* CONSTRUCTOR */

    /// @dev Initializes the contract.
    /// @param _owner The owner of the contract.
    /// @param _initialTimelock The initial timelock.
    /// @param _vaultIncentivesModule The vault incentives module.
    /// @param _asset The address of the underlying asset.
    /// @param _name The name of the vault.
    /// @param _symbol The symbol of the vault.
    constructor(
        address _owner,
        uint256 _initialTimelock,
        IVaultIncentivesModule _vaultIncentivesModule,
        address _asset,
        string memory _name,
        string memory _symbol
    ) ERC4626(IERC20(_asset)) ERC20Permit(_name) ERC20(_name, _symbol) Ownable(_owner) {
        require(_asset != address(0), ErrorsLib.ZeroAddress());
        require(address(_vaultIncentivesModule) != address(0), ErrorsLib.ZeroAddress());

        uint256 decimals = TokenHelper.assertAndGetDecimals(_asset);
        require(decimals <= 18, ErrorsLib.NotSupportedDecimals());
        DECIMALS_OFFSET = uint8(UtilsLib.zeroFloorSub(18 + 6, decimals));

        _checkTimelockBounds(_initialTimelock);
        _setTimelock(_initialTimelock);
        INCENTIVES_MODULE = _vaultIncentivesModule;
    }

    /* MODIFIERS */

    /// @dev Reverts if the caller doesn't have the curator role.
    modifier onlyCuratorRole() {
        address sender = _msgSender();
        if (sender != curator && sender != owner()) revert ErrorsLib.NotCuratorRole();

        _;
    }

    /// @dev Reverts if the caller doesn't have the allocator role.
    modifier onlyAllocatorRole() {
        address sender = _msgSender();
        if (!isAllocator[sender] && sender != curator && sender != owner()) {
            revert ErrorsLib.NotAllocatorRole();
        }

        _;
    }

    /// @dev Reverts if the caller doesn't have the guardian role.
    modifier onlyGuardianRole() {
        if (_msgSender() != owner() && _msgSender() != guardian) revert ErrorsLib.NotGuardianRole();

        _;
    }

    /// @dev Reverts if the caller doesn't have the curator nor the guardian role.
    modifier onlyCuratorOrGuardianRole() {
        if (_msgSender() != guardian && _msgSender() != curator && _msgSender() != owner()) {
            revert ErrorsLib.NotCuratorNorGuardianRole();
        }

        _;
    }

    /// @dev Makes sure conditions are met to accept a pending value.
    /// @dev Reverts if:
    /// - there's no pending value;
    /// - the timelock has not elapsed since the pending value has been submitted.
    modifier afterTimelock(uint256 _validAt) {
        if (_validAt == 0) revert ErrorsLib.NoPendingValue();
        if (block.timestamp < _validAt) revert ErrorsLib.TimelockNotElapsed();

        _;
    }

    /* ONLY OWNER FUNCTIONS */

    /// @inheritdoc ISiloVaultBase
    function setCurator(address _newCurator) external virtual onlyOwner {
        if (_newCurator == curator) revert ErrorsLib.AlreadySet();

        curator = _newCurator;

        emit EventsLib.SetCurator(_newCurator);
    }

    /// @inheritdoc ISiloVaultBase
    // 可设置为true or false
    function setIsAllocator(address _newAllocator, bool _newIsAllocator) external virtual onlyOwner {
        SiloVaultActionsLib.setIsAllocator(_newAllocator, _newIsAllocator, isAllocator);
    }

    /// @inheritdoc ISiloVaultBase
    function submitTimelock(uint256 _newTimelock) external virtual onlyOwner {
        if (_newTimelock == timelock) revert ErrorsLib.AlreadySet();
        if (pendingTimelock.validAt != 0) revert ErrorsLib.AlreadyPending();
        _checkTimelockBounds(_newTimelock);

        if (_newTimelock > timelock) {
            _setTimelock(_newTimelock);
        } else {
            // Safe "unchecked" cast because newTimelock <= MAX_TIMELOCK.
            pendingTimelock.update(uint184(_newTimelock), timelock);

            emit EventsLib.SubmitTimelock(_newTimelock);
        }
    }

    /// @inheritdoc ISiloVaultBase
    function setFee(uint256 _newFee) external virtual onlyOwner {
        if (_newFee == fee) revert ErrorsLib.AlreadySet();
        if (_newFee > ConstantsLib.MAX_FEE) revert ErrorsLib.MaxFeeExceeded();
        if (_newFee != 0 && feeRecipient == address(0)) revert ErrorsLib.ZeroFeeRecipient();

        // Accrue fee using the previous fee set before changing it.
        _updateLastTotalAssets(_accrueFee());

        // Safe "unchecked" cast because newFee <= MAX_FEE.
        fee = uint96(_newFee);

        emit EventsLib.SetFee(_msgSender(), fee);
    }

    /// @inheritdoc ISiloVaultBase
    function setFeeRecipient(address _newFeeRecipient) external virtual onlyOwner {
        if (_newFeeRecipient == feeRecipient) revert ErrorsLib.AlreadySet();
        if (_newFeeRecipient == address(0) && fee != 0) revert ErrorsLib.ZeroFeeRecipient();

        // Accrue fee to the previous fee recipient set before changing it.
        _updateLastTotalAssets(_accrueFee());

        feeRecipient = _newFeeRecipient;

        emit EventsLib.SetFeeRecipient(_newFeeRecipient);
    }

    /// @inheritdoc ISiloVaultBase
    // 预提交
    function submitGuardian(address _newGuardian) external virtual onlyOwner {
        if (_newGuardian == guardian) revert ErrorsLib.AlreadySet();
        if (pendingGuardian.validAt != 0) revert ErrorsLib.AlreadyPending();

        if (guardian == address(0)) {
            _setGuardian(_newGuardian);
        } else {
            pendingGuardian.update(_newGuardian, timelock);

            emit EventsLib.SubmitGuardian(_newGuardian);
        }
    }

    /* ONLY CURATOR FUNCTIONS */

    /// @inheritdoc ISiloVaultBase
    // 设置 ERC4626 市场供给上限
    function submitCap(IERC4626 _market, uint256 _newSupplyCap) external virtual onlyCuratorRole { // 策略管理人 执行
        if (_market.asset() != asset()) revert ErrorsLib.InconsistentAsset(_market);
        if (pendingCap[_market].validAt != 0) revert ErrorsLib.AlreadyPending(); // 时间锁条件
        if (config[_market].removableAt != 0) revert ErrorsLib.PendingRemoval();
        uint256 supplyCap = config[_market].cap;
        if (_newSupplyCap == supplyCap) revert ErrorsLib.AlreadySet();

        if (_newSupplyCap < supplyCap) { // 降低 cap
            _setCap(_market, SafeCast.toUint184(_newSupplyCap));
        } else {  // 提高 cap, 写入 pendingCap 映射，等待 validAt 到期才可生效
            pendingCap[_market].update(SafeCast.toUint184(_newSupplyCap), timelock);

            emit EventsLib.SubmitCap(_msgSender(), _market, _newSupplyCap);
        }
    }

    /// @inheritdoc ISiloVaultBase
    // 申请移除某个 ERC4626 市场
    function submitMarketRemoval(IERC4626 _market) external virtual onlyCuratorRole { // 策略管理人 执行
        if (config[_market].removableAt != 0) revert ErrorsLib.AlreadyPending();
        if (config[_market].cap != 0) revert ErrorsLib.NonZeroCap();
        if (!config[_market].enabled) revert ErrorsLib.MarketNotEnabled(_market);
        if (pendingCap[_market].validAt != 0) revert ErrorsLib.PendingCap(_market);

        // Safe "unchecked" cast because timelock <= MAX_TIMELOCK.
        config[_market].removableAt = uint64(block.timestamp + timelock); // 延迟生效

        emit EventsLib.SubmitMarketRemoval(_msgSender(), _market);
    }

    /* ONLY ALLOCATOR FUNCTIONS */

    /// @inheritdoc ISiloVaultBase
    function setSupplyQueue(IERC4626[] calldata _newSupplyQueue) external virtual onlyAllocatorRole {
        _nonReentrantOn();
        // 无检查机制,无条件信任调用者
        uint256 length = _newSupplyQueue.length;

        if (length > ConstantsLib.MAX_QUEUE_LENGTH) revert ErrorsLib.MaxQueueLengthExceeded();

        for (uint256 i; i < length; ++i) { // 逐个检查
            IERC4626 market = _newSupplyQueue[i];
            if (config[market].cap == 0) revert ErrorsLib.UnauthorizedMarket(market);
            // @q 其他检查项
        }

        supplyQueue = _newSupplyQueue;

        emit EventsLib.SetSupplyQueue(_msgSender(), _newSupplyQueue);

        _nonReentrantOff();
    }

    /// @inheritdoc ISiloVaultBase
    // 更新子市场提款优先顺序
    function updateWithdrawQueue(uint256[] calldata _indexes) external virtual onlyAllocatorRole {
        _nonReentrantOn();

        uint256 newLength = _indexes.length;
        uint256 currLength = withdrawQueue.length;

        bool[] memory seen = new bool[](currLength);
        IERC4626[] memory newWithdrawQueue = new IERC4626[](newLength);

        for (uint256 i; i < newLength; ++i) {
            uint256 prevIndex = _indexes[i];

            // If prevIndex >= currLength, it will revert with native "Index out of bounds".
            IERC4626 market = withdrawQueue[prevIndex];
            if (seen[prevIndex]) revert ErrorsLib.DuplicateMarket(market);
            seen[prevIndex] = true;

            newWithdrawQueue[i] = market;
        }

        // 处理被排除的市场是否符合「可被安全移除」条件
        for (uint256 i; i < currLength; ++i) {
            if (!seen[i]) {
                IERC4626 market = withdrawQueue[i];

                if (config[market].cap != 0) revert ErrorsLib.InvalidMarketRemovalNonZeroCap(market);
                if (pendingCap[market].validAt != 0) revert ErrorsLib.PendingCap(market);

                if (_ERC20BalanceOf(address(market), address(this)) != 0) {
                    if (config[market].removableAt == 0) revert ErrorsLib.InvalidMarketRemovalNonZeroSupply(market);

                    if (block.timestamp < config[market].removableAt) {
                        revert ErrorsLib.InvalidMarketRemovalTimelockNotElapsed(market);
                    }
                }

                delete config[market];
            }
        }

        withdrawQueue = newWithdrawQueue;

        emit EventsLib.SetWithdrawQueue(_msgSender(), newWithdrawQueue);

        _nonReentrantOff();
    }

    /// @inheritdoc ISiloVaultBase
    // 核心函数: 在多个 ERC4626 vault(market)之间进行流动性的重新分配
    // 将资产从一些 market 中提取，再将这些资产注入到其他 market，以达到资金再平衡目的
    // 传入要操作的 market 以及要保留的最终资产
    // 由PublicAllocator调用
    function reallocate(MarketAllocation[] calldata _allocations) external virtual onlyAllocatorRole { // 由 allocator 策略合约调用
        _nonReentrantOn();

        uint256 totalSupplied;
        uint256 totalWithdrawn;
        for (uint256 i; i < _allocations.length; ++i) {
            MarketAllocation memory allocation = _allocations[i];

            // Update internal balance for market to include interest if any.
            _updateInternalBalanceForMarket(allocation.market);

            // in original SiloVault, we are not checking liquidity, so this reallocation will fail if not enough assets

            // vault合约在market上的asstes和shares
            (uint256 supplyAssets, uint256 supplyShares) = _supplyBalance(allocation.market);
            // 需要取出的资产 = 总资产 - 更新为的资产
            uint256 withdrawn = UtilsLib.zeroFloorSub(supplyAssets, allocation.assets);

            if (withdrawn > 0) { // 需要撤资
                if (!config[allocation.market].enabled) revert ErrorsLib.MarketNotEnabled(allocation.market);

                // Guarantees that unknown frontrunning donations can be withdrawn, in order to disable a market.
                uint256 shares;
                if (allocation.assets == 0) {
                    shares = supplyShares;
                    withdrawn = 0;
                }

                uint256 withdrawnAssets;
                uint256 withdrawnShares;

                // 从 market 中撤出资金
                if (shares != 0) {
                    // 取出 X 资产
                    // 该vault合约在market中持有的资产
                    withdrawnAssets = allocation.market.redeem(shares, address(this), address(this));
                    withdrawnShares = shares;
                } else {
                    // 赎回 Y 份额对应的资产
                    withdrawnAssets = withdrawn;
                    withdrawnShares = allocation.market.withdraw(withdrawn, address(this), address(this));
                }

                // Balances tracker can accumulate dust.
                // For example, if a user has deposited 100wei and withdrawn 99wei (because of rounding),
                // we will still have 1wei in balanceTracker[market]. But, this dust can be covered
                // by accrued interest over time.
                // 更新该合约自己的余额追踪信息
                balanceTracker[allocation.market] = UtilsLib.zeroFloorSub(
                    balanceTracker[allocation.market],
                    withdrawnAssets
                );

                emit EventsLib.ReallocateWithdraw(_msgSender(), allocation.market, withdrawnAssets, withdrawnShares);

                totalWithdrawn += withdrawnAssets;
            } else { // 否则, 补充资产,进行注资
                // 如果是 MAX,则表示将所有取出的资金注入该 market
                uint256 suppliedAssets = allocation.assets == type(uint256).max
                    ? UtilsLib.zeroFloorSub(totalWithdrawn, totalSupplied)
                    : UtilsLib.zeroFloorSub(allocation.assets, supplyAssets);

                if (suppliedAssets == 0) continue;

                uint256 supplyCap = config[allocation.market].cap;
                if (supplyCap == 0) revert ErrorsLib.UnauthorizedMarket(allocation.market);

                if (supplyAssets + suppliedAssets > supplyCap) revert ErrorsLib.SupplyCapExceeded(allocation.market);

                uint256 newBalance = balanceTracker[allocation.market] + suppliedAssets;

                if (newBalance > supplyCap) revert ErrorsLib.InternalSupplyCapExceeded(allocation.market);

                balanceTracker[allocation.market] = newBalance;

                // The market's loan asset is guaranteed to be the vault's asset because it has a non-zero supply cap.
                // 真正进行注资
                // @q 这里能否欺骗valut,使其注资?
                uint256 suppliedShares = allocation.market.deposit(suppliedAssets, address(this));

                emit EventsLib.ReallocateSupply(_msgSender(), allocation.market, suppliedAssets, suppliedShares);

                totalSupplied += suppliedAssets;
            }
        }

        // 确保最终资产数量平衡
        if (totalWithdrawn != totalSupplied) revert ErrorsLib.InconsistentReallocation();

        _nonReentrantOff();
    }

    /* REVOKE FUNCTIONS */

    /// @inheritdoc ISiloVaultBase
    // 撤销尚未生效的 timelock 修改提案(治理)
    function revokePendingTimelock() external virtual onlyGuardianRole {
        delete pendingTimelock;

        emit EventsLib.RevokePendingTimelock(_msgSender());
    }

    /// @inheritdoc ISiloVaultBase
    function revokePendingGuardian() external virtual onlyGuardianRole {
        delete pendingGuardian;

        emit EventsLib.RevokePendingGuardian(_msgSender());
    }

    /// @inheritdoc ISiloVaultBase
    function revokePendingCap(IERC4626 _market) external virtual onlyCuratorOrGuardianRole {
        delete pendingCap[_market];

        emit EventsLib.RevokePendingCap(_msgSender(), _market);
    }

    /// @inheritdoc ISiloVaultBase
    function revokePendingMarketRemoval(IERC4626 _market) external virtual onlyCuratorOrGuardianRole {
        delete config[_market].removableAt;

        emit EventsLib.RevokePendingMarketRemoval(_msgSender(), _market);
    }

    /* EXTERNAL */

    /// @inheritdoc ISiloVaultBase
    function supplyQueueLength() external view virtual returns (uint256) {
        return supplyQueue.length;
    }

    /// @inheritdoc ISiloVaultBase
    function withdrawQueueLength() external view virtual returns (uint256) {
        return withdrawQueue.length;
    }

    /// @inheritdoc ISiloVaultBase
    function acceptTimelock() external virtual afterTimelock(pendingTimelock.validAt) {
        _setTimelock(pendingTimelock.value);
    }

    /// @inheritdoc ISiloVaultBase
    // 正式执行
    function acceptGuardian() external virtual afterTimelock(pendingGuardian.validAt) {
        _setGuardian(pendingGuardian.value);
    }

    /// @inheritdoc ISiloVaultBase
    // 正式应用此前由 curator 提交的 cap 变更提案
    function acceptCap(IERC4626 _market) external virtual afterTimelock(pendingCap[_market].validAt) {
        _nonReentrantOn();

        // Safe "unchecked" cast because pendingCap <= type(uint184).max.
        _setCap(_market, uint184(pendingCap[_market].value));

        _nonReentrantOff();
    }

    /// @inheritdoc ISiloVaultBase
    // @f
    function claimRewards() public virtual { // @q 各类重入或执行意外逻辑?
        // 使用 transient 自己实现重入锁
        _nonReentrantOn();

        _updateLastTotalAssets(_accrueFee());
        _claimRewards();

        _nonReentrantOff();
    }

    /// @inheritdoc ISiloVaultBase
    function reentrancyGuardEntered() external view virtual returns (bool entered) {
        entered = _lock;
    }

    /* ERC4626 (PUBLIC) */

    /// @inheritdoc IERC20Metadata
    function decimals() public view virtual override(ERC20, ERC4626) returns (uint8) {
        return 18;
    }

    /// @inheritdoc IERC4626
    /// @dev Warning: May be higher than the actual max deposit due to duplicate markets in the supplyQueue.
    //  最多还能注入资产
    function maxDeposit(address) public view virtual override returns (uint256) {
        return _maxDeposit();
    }

    /// @inheritdoc IERC4626
    /// @dev Warning: May be higher than the actual max mint due to duplicate markets in the supplyQueue.
    //  最多还能 mint 份额
    function maxMint(address) public view virtual override returns (uint256) {
        uint256 suppliable = _maxDeposit();
        // 做转换
        return _convertToShares(suppliable, Math.Rounding.Floor);
    }

    /// @inheritdoc IERC4626
    /// @dev Warning: May be lower than the actual amount of assets that can be withdrawn by `owner` due to conversion
    /// roundings between shares and assets.
    // 最多能提取的资产数量
    function maxWithdraw(address _owner) public view virtual override returns (uint256 assets) {
        (assets, , ) = _maxWithdraw(_owner);
    }

    /// @inheritdoc IERC4626
    /// @dev Warning: May be lower than the actual amount of shares that can be redeemed by `owner` due to conversion
    /// roundings between shares and assets.
    // 最多能赎回的份额
    function maxRedeem(address _owner) public view virtual override returns (uint256) {
        (uint256 assets, uint256 newTotalSupply, uint256 newTotalAssets) = _maxWithdraw(_owner);
        // 资产 -> shares
        return _convertToSharesWithTotals(assets, newTotalSupply, newTotalAssets, Math.Rounding.Floor);
    }

    /// @inheritdoc IERC20
    // @q-a 由谁调用? - 用户或合约, 将自己的shares转给其他人
    // @audit- 随意转移股份, 造成其他副作用 - 奖励计算 | withdrawQueue | HookReceiver
    // - 如转移路径: userA -> vault -> userB
    function transfer(address _to, uint256 _value) public virtual override(ERC20, IERC20) returns (bool success) {
        // @q-a QA 能否将_nonReentrant优化为 modifier - 在 reallocate、rebalance 逻辑里间断式启用,这样更灵活
        _nonReentrantOn();
        // 转移股份, 由合约转给 _to 地址
        success = ERC20.transfer(_to, _value);

        _nonReentrantOff();
    }

    /// @inheritdoc IERC20
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public virtual override(ERC20, IERC20) returns (bool success) {
        _nonReentrantOn();

        success = ERC20.transferFrom(_from, _to, _value);

        _nonReentrantOff();
    }

    /// @inheritdoc IERC4626
    // @entry
    // 用户: assets -> shares
    function deposit(uint256 _assets, address _receiver) public virtual override returns (uint256 shares) {
        _nonReentrantOn();

        uint256 newTotalAssets = _accrueFee();

        // Update `lastTotalAssets` to avoid an inconsistent state in a re-entrant context.
        // It is updated again in `_deposit`.
        lastTotalAssets = newTotalAssets;

        shares = _convertToSharesWithTotalsSafe(_assets, totalSupply(), newTotalAssets, Math.Rounding.Floor);

        _deposit(_msgSender(), _receiver, _assets, shares);

        _nonReentrantOff();
    }

    /// @inheritdoc IERC4626
    // @entry
    // 投入asset铸造出_shares, 可指定 _receiver
    function mint(uint256 _shares, address _receiver) public virtual override returns (uint256 assets) {
        _nonReentrantOn();

        uint256 newTotalAssets = _accrueFee();

        // Update `lastTotalAssets` to avoid an inconsistent state in a re-entrant context.
        // It is updated again in `_deposit`.
        lastTotalAssets = newTotalAssets;

        // 计算为了获得 _shares，需要存入多少资产
        assets = _convertToAssetsWithTotalsSafe(_shares, totalSupply(), newTotalAssets, Math.Rounding.Ceil);

        _deposit(_msgSender(), _receiver, assets, _shares);

        _nonReentrantOff();
    }

    /// @inheritdoc IERC4626
    // @entry
    function withdraw(
        uint256 _assets,
        address _receiver,
        address _owner
    ) public virtual override returns (uint256 shares) {
        _nonReentrantOn();

        uint256 newTotalAssets = _accrueFee();

        // Do not call expensive `maxWithdraw` and optimistically withdraw assets.

        shares = _convertToSharesWithTotalsSafe(_assets, totalSupply(), newTotalAssets, Math.Rounding.Ceil);

        // `newTotalAssets - assets` may be a little off from `totalAssets()`.
        _updateLastTotalAssets(UtilsLib.zeroFloorSub(newTotalAssets, _assets));

        _withdraw(_msgSender(), _receiver, _owner, _assets, shares);

        _nonReentrantOff();
    }

    /// @inheritdoc IERC4626
    // @entry
    function redeem(
        uint256 _shares,
        address _receiver,
        address _owner
    ) public virtual override returns (uint256 assets) {
        _nonReentrantOn();

        uint256 newTotalAssets = _accrueFee();

        // Do not call expensive `maxRedeem` and optimistically redeem shares.

        assets = _convertToAssetsWithTotalsSafe(_shares, totalSupply(), newTotalAssets, Math.Rounding.Floor);

        // `newTotalAssets - assets` may be a little off from `totalAssets()`.
        _updateLastTotalAssets(UtilsLib.zeroFloorSub(newTotalAssets, assets));

        _withdraw(_msgSender(), _receiver, _owner, assets, _shares);

        _nonReentrantOff();
    }

    /// @inheritdoc IERC4626
    function totalAssets() public view virtual override returns (uint256 assets) {
        for (uint256 i; i < withdrawQueue.length; ++i) {
            IERC4626 market = withdrawQueue[i];
            assets += _expectedSupplyAssets(market, address(this));
        }
    }

    /* ERC4626 (INTERNAL) */

    /// @inheritdoc ERC4626
    function _decimalsOffset() internal view virtual override returns (uint8) {
        return DECIMALS_OFFSET;
    }

    /// @dev Returns the maximum amount of asset (`assets`) that the `owner` can withdraw from the vault, as well as the
    /// new vault's total supply (`newTotalSupply`) and total assets (`newTotalAssets`).
    // 最多能提取的资产数量
    function _maxWithdraw(
        address _owner
    ) internal view virtual returns (uint256 assets, uint256 newTotalSupply, uint256 newTotalAssets) {
        uint256 feeShares;
        (feeShares, newTotalAssets) = _accruedFeeShares();
        // shares
        newTotalSupply = totalSupply() + feeShares;
        // 当前总资产
        assets = _convertToAssetsWithTotals(balanceOf(_owner), newTotalSupply, newTotalAssets, Math.Rounding.Floor);
        // 模拟从各 vault 提取资金时的实际损耗
        assets -= SiloVaultActionsLib.simulateWithdrawERC4626(assets, withdrawQueue);
    }

    /// @dev Returns the maximum amount of assets that the vault can supply to ERC4626 vaults.
    // 最多还能注入多少资产
    function _maxDeposit() internal view virtual returns (uint256 totalSuppliable) {
        for (uint256 i; i < supplyQueue.length; ++i) {
            IERC4626 market = supplyQueue[i];

            uint256 supplyCap = config[market].cap;
            if (supplyCap == 0) continue;
            // 当前资产
            (uint256 assets, ) = _supplyBalance(market);
            uint256 depositMax = market.maxDeposit(address(this));
            // 可注入量
            uint256 suppliable = Math.min(depositMax, UtilsLib.zeroFloorSub(supplyCap, assets));

            if (suppliable == 0) continue;

            uint256 internalBalance = balanceTracker[market];

            // We reached a cap of the market by internal balance, so we can't supply more
            // 若达到 cap,则不允许注资
            if (internalBalance >= supplyCap) continue;

            uint256 internalSuppliable;
            // safe to uncheck because internalBalance < supplyCap
            unchecked {
                // 注资额度
                internalSuppliable = supplyCap - internalBalance;
            }
            // 累加
            totalSuppliable += Math.min(suppliable, internalSuppliable);
        }
    }

    /// @inheritdoc ERC4626
    /// @dev The accrual of performance fees is taken into account in the conversion.
    function _convertToShares(
        uint256 _assets,
        Math.Rounding _rounding
    ) internal view virtual override returns (uint256) {
        (uint256 feeShares, uint256 newTotalAssets) = _accruedFeeShares();

        return _convertToSharesWithTotals(_assets, totalSupply() + feeShares, newTotalAssets, _rounding);
    }

    /// @inheritdoc ERC4626
    /// @dev The accrual of performance fees is taken into account in the conversion.
    function _convertToAssets(
        uint256 _shares,
        Math.Rounding _rounding
    ) internal view virtual override returns (uint256) {
        (uint256 feeShares, uint256 newTotalAssets) = _accruedFeeShares();

        return _convertToAssetsWithTotals(_shares, totalSupply() + feeShares, newTotalAssets, _rounding);
    }

    /// @dev Returns the amount of shares that the vault would exchange for the amount of `assets` provided.
    /// @dev It assumes that the arguments `newTotalSupply` and `newTotalAssets` are up to date.
    function _convertToSharesWithTotals(
        uint256 _assets,
        uint256 _newTotalSupply,
        uint256 _newTotalAssets,
        Math.Rounding _rounding
    ) internal view virtual returns (uint256) {
        // _assets * (_newTotalSupply + 10 ** decimals) / _newTotalAssets + 1
        // _newTotalAssets + 1 避免除 0
        return _assets.mulDiv(_newTotalSupply + 10 ** _decimalsOffset(), _newTotalAssets + 1, _rounding);
    }

    /// @dev Returns the amount of shares that the vault would exchange for the amount of `assets` provided.
    /// @dev It assumes that the arguments `newTotalSupply` and `newTotalAssets` are up to date.
    /// @dev Reverts if the result is zero.
    function _convertToSharesWithTotalsSafe(
        uint256 _assets,
        uint256 _newTotalSupply,
        uint256 _newTotalAssets,
        Math.Rounding _rounding
    ) internal view virtual returns (uint256 shares) {
        shares = _convertToSharesWithTotals(_assets, _newTotalSupply, _newTotalAssets, _rounding);
        require(shares != 0, ErrorsLib.ZeroShares());
    }

    /// @dev Returns the amount of assets that the vault would exchange for the amount of `shares` provided.
    /// @dev It assumes that the arguments `newTotalSupply` and `newTotalAssets` are up to date.
    function _convertToAssetsWithTotals(
        uint256 _shares,
        uint256 _newTotalSupply,
        uint256 _newTotalAssets,
        Math.Rounding _rounding
    ) internal view virtual returns (uint256) {
        return _shares.mulDiv(_newTotalAssets + 1, _newTotalSupply + 10 ** _decimalsOffset(), _rounding);
    }

    /// @dev Returns the amount of assets that the vault would exchange for the amount of `shares` provided.
    /// @dev It assumes that the arguments `newTotalSupply` and `newTotalAssets` are up to date.
    /// @dev Reverts if the result is zero.
    function _convertToAssetsWithTotalsSafe(
        uint256 _shares,
        uint256 _newTotalSupply,
        uint256 _newTotalAssets,
        Math.Rounding _rounding
    ) internal view virtual returns (uint256 assets) {
        assets = _convertToAssetsWithTotals(_shares, _newTotalSupply, _newTotalAssets, _rounding);
        require(assets != 0, ErrorsLib.ZeroAssets());
    }

    /// @inheritdoc ERC4626
    /// @dev Used in mint or deposit to deposit the underlying asset to ERC4626 vaults.
    function _deposit(address _caller, address _receiver, uint256 _assets, uint256 _shares) internal virtual override {
        if (_shares == 0) revert ErrorsLib.InputZeroShares();
        // @q ERC4626会不会重入?称可支持任何 ERC-4626 金库
        super._deposit(_caller, _receiver, _assets, _shares);
        // 将资产分派到各个 market 当中
        _supplyERC4626(_assets);

        // `lastTotalAssets + assets` may be a little off from `totalAssets()`.
        _updateLastTotalAssets(lastTotalAssets + _assets);
    }

    /// @inheritdoc ERC4626
    /// @dev Used in redeem or withdraw to withdraw the underlying asset from ERC4626 markets.
    /// @dev Depending on 3 cases, reverts when withdrawing "too much" with:
    /// 1. NotEnoughLiquidity when withdrawing more than available liquidity.
    /// 2. ERC20InsufficientAllowance when withdrawing more than `caller`'s allowance.
    /// 3. ERC20InsufficientBalance when withdrawing more than `owner`'s balance.
    function _withdraw(
        address _caller,
        address _receiver,
        address _owner,
        uint256 _assets,
        uint256 _shares
    ) internal virtual override {
        _withdrawERC4626(_assets);

        super._withdraw(_caller, _receiver, _owner, _assets, _shares);
    }

    /* INTERNAL */

    /// @dev Updates the internal balance for the market.
    function _updateInternalBalanceForMarket(IERC4626 _market) internal virtual returns (uint256 marketBalance) {
        marketBalance = _expectedSupplyAssets(_market, address(this));
        // 更新 marketBalance
        if (marketBalance != 0 && marketBalance > balanceTracker[_market]) {
            // We do not take into account assets lose in the market allocation but we allow it on the deposit
            // because of that `newAllocation` can be less than `currentAllocation` up to allowed assets loss.
            balanceTracker[_market] = marketBalance;
        }
    }

    /// @dev Returns the vault's assets & corresponding shares supplied on the
    /// market defined by `market`, as well as the market's state.
    function _supplyBalance(IERC4626 _market) internal view virtual returns (uint256 assets, uint256 shares) {
        shares = _ERC20BalanceOf(address(_market), address(this));
        // we assume here, that in case of any interest on IERC4626, convertToAssets returns assets with interest
        assets = _previewRedeem(_market, shares);
    }

    /// @dev Reverts if `newTimelock` is not within the bounds.
    function _checkTimelockBounds(uint256 _newTimelock) internal pure virtual {
        if (_newTimelock > ConstantsLib.MAX_TIMELOCK) revert ErrorsLib.AboveMaxTimelock();
        if (_newTimelock < ConstantsLib.MIN_TIMELOCK) revert ErrorsLib.BelowMinTimelock();
    }

    /// @dev Sets `timelock` to `newTimelock`.
    function _setTimelock(uint256 _newTimelock) internal virtual {
        timelock = _newTimelock;

        emit EventsLib.SetTimelock(_msgSender(), _newTimelock);

        delete pendingTimelock;
    }

    /// @dev Sets `guardian` to `newGuardian`.
    function _setGuardian(address _newGuardian) internal virtual {
        guardian = _newGuardian;

        emit EventsLib.SetGuardian(_msgSender(), _newGuardian);

        delete pendingGuardian;
    }

    /// @dev Sets the cap of the market.
    function _setCap(IERC4626 _market, uint184 _supplyCap) internal virtual {
        bool updateTotalAssets = SiloVaultActionsLib.setCap(
            _market,
            _supplyCap,
            asset(),
            config,
            pendingCap,
            withdrawQueue
        );

        if (updateTotalAssets) {
            _updateLastTotalAssets(lastTotalAssets + _expectedSupplyAssets(_market, address(this)));
        }
    }

    /* LIQUIDITY ALLOCATION */

    /// @dev Supplies `assets` to ERC4626 vaults.
    // 资产按顺序注入多个 ERC4626 子 vault 中
    function _supplyERC4626(uint256 _assets) internal virtual {
        for (uint256 i; i < supplyQueue.length; ++i) {
            IERC4626 market = supplyQueue[i];

            uint256 supplyCap = config[market].cap;
            if (supplyCap == 0) continue;

            // Update internal balance for market to include interest if any.
            // `supplyAssets` needs to be rounded up for `toSupply` to be rounded down.
            // 更新 balanceTracker，包含最新利息
            uint256 supplyAssets = _updateInternalBalanceForMarket(market);
            // toSupply = min(supplyCap - supplyAssets, _assets);
            // 如果一个market当中
            uint256 toSupply = UtilsLib.min(UtilsLib.zeroFloorSub(supplyCap, supplyAssets), _assets);

            if (toSupply != 0) {
                uint256 newBalance = balanceTracker[market] + toSupply;
                // As `_supplyBalance` reads the balance directly from the market,
                // we have additional check to ensure that the market did not report wrong supply.
                if (newBalance <= supplyCap) {
                    // Using try/catch to skip markets that revert.
                    try market.deposit(toSupply, address(this)) {
                        _assets -= toSupply;
                        balanceTracker[market] = newBalance;
                    } catch {}
                }
            }
            // 如果资产全部分派完,提取返回
            if (_assets == 0) return;
        }

        if (_assets != 0) revert ErrorsLib.AllCapsReached();
    }

    /// @dev Withdraws `assets` from ERC4626 vaults.
    function _withdrawERC4626(uint256 _assets) internal virtual {
        // 从各个erc4626 market中 withdraw
        for (uint256 i; i < withdrawQueue.length; ++i) {
            IERC4626 market = withdrawQueue[i];

            // Update internal balance for market to include interest if any.
            _updateInternalBalanceForMarket(market);

            // original implementation were using `_accruedSupplyBalance` which does not care about liquidity
            // now, liquidity is considered by using `maxWithdraw`
            uint256 toWithdraw = UtilsLib.min(market.maxWithdraw(address(this)), _assets);

            if (toWithdraw > 0) {
                // Using try/catch to skip markets that revert.
                try market.withdraw(toWithdraw, address(this), address(this)) {
                    _assets -= toWithdraw;

                    // Balances tracker can accumulate dust.
                    // For example, if a user has deposited 100wei and withdrawn 99wei (because of rounding),
                    // we will still have 1wei in balanceTracker[market]. But, this dust can be covered
                    // by accrued interest over time.
                    balanceTracker[market] = UtilsLib.zeroFloorSub(balanceTracker[market], toWithdraw);
                } catch {}
            }

            if (_assets == 0) return;
        }

        if (_assets != 0) revert ErrorsLib.NotEnoughLiquidity();
    }

    /* FEE MANAGEMENT */

    /// @dev Updates `lastTotalAssets` to `updatedTotalAssets`.
    function _updateLastTotalAssets(uint256 _updatedTotalAssets) internal virtual {
        lastTotalAssets = _updatedTotalAssets;

        emit EventsLib.UpdateLastTotalAssets(_updatedTotalAssets);
    }

    /// @dev Accrues the fee and mints the fee shares to the fee recipient.
    /// @return newTotalAssets The vaults total assets after accruing the interest.
    function _accrueFee() internal virtual returns (uint256 newTotalAssets) {
        uint256 feeShares;
        (feeShares, newTotalAssets) = _accruedFeeShares();

        if (feeShares != 0) _mint(feeRecipient, feeShares);

        emit EventsLib.AccrueInterest(newTotalAssets, feeShares);
    }

    /// @dev Computes and returns the fee shares (`feeShares`) to mint and the new vault's total assets
    /// (`newTotalAssets`).
    function _accruedFeeShares() internal view virtual returns (uint256 feeShares, uint256 newTotalAssets) {
        newTotalAssets = totalAssets();
        // 总利息 = 当前总资产 - 上次结算资产
        uint256 totalInterest = UtilsLib.zeroFloorSub(newTotalAssets, lastTotalAssets);
        if (totalInterest != 0 && fee != 0) {
            // It is acknowledged that `feeAssets` may be rounded down to 0 if `totalInterest * fee < WAD`.
            // 高精度计算, fee assets
            uint256 feeAssets = totalInterest.mulDiv(fee, WAD);
            // The fee assets is subtracted from the total assets in this calculation to compensate for the fact
            // that total assets is already increased by the total interest (including the fee assets).
            // assets 换算成 fee shares
            feeShares = _convertToSharesWithTotals(
                feeAssets,
                totalSupply(),
                newTotalAssets - feeAssets,
                Math.Rounding.Floor
            );
        }
    }

    /// @notice Returns the expected supply assets balance of `user` on a market after having accrued interest.
    function _expectedSupplyAssets(IERC4626 _market, address _user) internal view virtual returns (uint256 assets) {
        assets = _previewRedeem(_market, _ERC20BalanceOf(address(_market), _user));
    }

    function _update(address _from, address _to, uint256 _value) internal virtual override {
        // on deposit, claim must be first action, new user should not get reward

        // on withdraw, claim must be first action, user that is leaving should get rewards
        // immediate deposit-withdraw operation will not abused it, because before deposit all rewards will be
        // claimed, so on withdraw on the same block no additional rewards will be generated.

        // transfer shares is basically withdraw->deposit, so claiming rewards should be done before any state changes

        _claimRewards();

        super._update(_from, _to, _value);

        if (_value == 0) return;

        _afterTokenTransfer(_from, _to, _value);
    }

    function _afterTokenTransfer(address _from, address _to, uint256 _value) internal virtual {
        address[] memory receivers = INCENTIVES_MODULE.getNotificationReceivers();

        uint256 total = totalSupply();
        uint256 senderBalance = _from == address(0) ? 0 : balanceOf(_from);
        uint256 recipientBalance = _to == address(0) ? 0 : balanceOf(_to);

        for (uint256 i; i < receivers.length; i++) {
            INotificationReceiver(receivers[i]).afterTokenTransfer({
                _sender: _from,
                _senderBalance: senderBalance,
                _recipient: _to,
                _recipientBalance: recipientBalance,
                _totalSupply: total,
                _amount: _value
            });
        }
    }

    function _claimRewards() internal virtual {
        // 获取所有IncentivesClaimingLogics的奖励
        address[] memory logics = INCENTIVES_MODULE.getAllIncentivesClaimingLogics();
        bytes memory data = abi.encodeWithSelector(IIncentivesClaimingLogic.claimRewardsAndDistribute.selector);
        // @f-a for loop + lowlevel call - logic limit
        for (uint256 i; i < logics.length; i++) {
            (bool success, ) = logics[i].delegatecall(data); // delegatecall claimRewardsAndDistribute
            if (!success) revert ErrorsLib.ClaimRewardsFailed();
        }
    }

    function _nonReentrantOn() internal {
        require(!_lock, ErrorsLib.ReentrancyError());
        _lock = true;
    }

    function _nonReentrantOff() internal {
        _lock = false;
    }

    /// @dev to save code size ~500 B
    function _ERC20BalanceOf(address _token, address _account) internal view returns (uint256 balance) {
        balance = IERC20(_token).balanceOf(_account);
    }

    function _previewRedeem(IERC4626 _market, uint256 _shares) internal view returns (uint256 assets) {
        assets = _market.previewRedeem(_shares);
    }
}
