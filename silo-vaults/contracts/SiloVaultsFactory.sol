// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity 0.8.28;

import {Clones} from "openzeppelin5/proxy/Clones.sol";

import {ISiloVault} from "./interfaces/ISiloVault.sol";
import {ISiloVaultsFactory} from "./interfaces/ISiloVaultsFactory.sol";

import {EventsLib} from "./libraries/EventsLib.sol";

import {SiloVault} from "./SiloVault.sol";
import {VaultIncentivesModule} from "./incentives/VaultIncentivesModule.sol";

/// @title SiloVaultsFactory
/// @dev Forked with gratitude from Morpho Labs.
/// @author Silo Labs
/// @custom:contact security@silo.finance
/// @notice This contract allows to create SiloVault vaults, and to index them easily.
contract SiloVaultsFactory is ISiloVaultsFactory {
    /* STORAGE */
    address public immutable VAULT_INCENTIVES_MODULE_IMPLEMENTATION;

    /// @inheritdoc ISiloVaultsFactory
    mapping(address => bool) public isSiloVault;

    mapping(address owner => uint256 counter) public counter;

    /* CONSTRUCTOR */

    constructor() {
        VAULT_INCENTIVES_MODULE_IMPLEMENTATION = address(new VaultIncentivesModule());
    }

    /* EXTERNAL */

    /// @inheritdoc ISiloVaultsFactory
    function createSiloVault(
        address initialOwner,
        uint256 initialTimelock,
        address asset,
        string memory name,
        string memory symbol
    ) external virtual returns (ISiloVault siloVault) {
        // @q-a salt 会哈希碰撞吗 - no
        bytes32 salt = keccak256(
            abi.encodePacked(counter[msg.sender]++, msg.sender, initialOwner, initialTimelock, asset, name, symbol)
        );

        VaultIncentivesModule vaultIncentivesModule = VaultIncentivesModule(
            Clones.cloneDeterministic(VAULT_INCENTIVES_MODULE_IMPLEMENTATION, salt)
        );
        // 创建一个个 siloVault
        // @q-a 会生成地址相同的实例吗 - no
        siloVault = ISiloVault(
            address(new SiloVault(initialOwner, initialTimelock, vaultIncentivesModule, asset, name, symbol))
        );

        vaultIncentivesModule.__VaultIncentivesModule_init(initialOwner, siloVault);

        isSiloVault[address(siloVault)] = true;

        emit EventsLib.CreateSiloVault(
            address(siloVault),
            msg.sender,
            initialOwner,
            initialTimelock,
            asset,
            name,
            symbol
        );
    }
}
