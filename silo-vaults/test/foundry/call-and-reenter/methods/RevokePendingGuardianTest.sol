// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.28;

import {MethodReentrancyTest} from "silo-core/test/foundry/Silo/reentrancy/methods/MethodReentrancyTest.sol";
import {TestStateLib} from "silo-vaults/test/foundry/call-and-reenter/TestState.sol";
import {ISiloVault} from "silo-vaults/contracts/interfaces/ISiloVault.sol";
import {ErrorsLib} from "silo-vaults/contracts/libraries/ErrorsLib.sol";

contract RevokePendingGuardianTest is MethodReentrancyTest {
    function callMethod() external {
        emit log_string("\tEnsure it is protected");
        _ensureItIsProtected();
    }

    function verifyReentrancy() external {
        _ensureItIsProtected();
    }

    function methodDescription() external pure returns (string memory description) {
        description = "revokePendingGuardian()";
    }

    function _ensureItIsProtected() internal {
        ISiloVault vault = TestStateLib.vault();

        vm.expectRevert(ErrorsLib.NotGuardianRole.selector);
        vault.revokePendingGuardian();
    }
}
