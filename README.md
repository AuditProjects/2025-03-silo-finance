# Silo Finance audit details
- Total Prize Pool: $50,000 in USDC
  - HM awards: $33,500 in USDC
  - QA awards: $1,400 in USDC
  - Judge awards: $4,000 in USDC
  - Validator awards: $2,600 in USDC 
  - Scout awards: $500 in USDC
  - Mitigation Review: $8,000 in USDC
- [Read our guidelines for more details](https://docs.code4rena.com/roles/wardens)
- Starts March 24, 2025 20:00 UTC
- Ends March 31, 2025 20:00 UTC

**Note re: risk level upgrades/downgrades**

Two important notes about judging phase risk adjustments: 
- High- or Medium-risk submissions downgraded to Low-risk (QA) will be ineligible for awards.
- Upgrading a Low-risk finding from a QA report to a Medium- or High-risk finding is not supported.

As such, wardens are encouraged to select the appropriate risk level carefully during the submission phase.

## Automated Findings / Publicly Known Issues

The 4naly3er report can be found [here](https://github.com/code-423n4/2025-01-silo-finance/blob/main/4naly3er-report.md).



_Note for C4 wardens: Anything included in this `Automated Findings / Publicly Known Issues` section is considered a publicly known issue and is ineligible for awards._

Donation/first deposit attack is possible but unprofitable because of decimal offset.

Certora audit: M-03
Certora audit: L-07
Certora audit: I-01
Certora audit: I-02
Sigma Prime: SILV-03
Sigma Prime: SILV-05
Sigma Prime: SILV-06
Sigma Prime: SILV-08
Sigma Prime: SILV-09

✅ SCOUTS: Please format the response above 👆 so its not a wall of text and its readable.

# Overview

[ ⭐️ SPONSORS: add info here ]

## Links

- **Previous audits:**  https://drive.google.com/drive/folders/1WjygQr40wT3-0XnOHcT1Fo9ef8acyRCV?usp=sharing
  - ✅ SCOUTS: If there are multiple report links, please format them in a list.
- **Documentation:** https://docs.morpho.org/morpho-vaults/overview
- **Website:** 🐺 CA: add a link to the sponsor's website
- **X/Twitter:** https://x.com/SiloFinance
- **Discord:** 🐺 CA: add a link to the sponsor's Discord

---

# Scope

[ ✅ SCOUTS: add scoping and technical details here ]

### Files in scope
- ✅ This should be completed using the `metrics.md` file
- ✅ Last row of the table should be Total: SLOC
- ✅ SCOUTS: Have the sponsor review and and confirm in text the details in the section titled "Scoping Q amp; A"

*For sponsors that don't use the scoping tool: list all files in scope in the table below (along with hyperlinks) -- and feel free to add notes to emphasize areas of focus.*

| Contract | SLOC | Purpose | Libraries used |  
| ----------- | ----------- | ----------- | ----------- |
| [contracts/folder/sample.sol](https://github.com/code-423n4/repo-name/blob/contracts/folder/sample.sol) | 123 | This contract does XYZ | [`@openzeppelin/*`](https://openzeppelin.com/contracts/) |

### Files out of scope
✅ SCOUTS: List files/directories out of scope

## Scoping Q &amp; A

### General questions
### Are there any ERC20's in scope?: Yes

✅ SCOUTS: If the answer above 👆 is "Yes", please add the tokens below 👇 to the table. Otherwise, update the column with "None".

Any (all possible ERC20s)


### Are there any ERC777's in scope?: No

✅ SCOUTS: If the answer above 👆 is "Yes", please add the tokens below 👇 to the table. Otherwise, update the column with "None".



### Are there any ERC721's in scope?: No

✅ SCOUTS: If the answer above 👆 is "Yes", please add the tokens below 👇 to the table. Otherwise, update the column with "None".



### Are there any ERC1155's in scope?: No

✅ SCOUTS: If the answer above 👆 is "Yes", please add the tokens below 👇 to the table. Otherwise, update the column with "None".



✅ SCOUTS: Once done populating the table below, please remove all the Q/A data above.

| Question                                | Answer                       |
| --------------------------------------- | ---------------------------- |
| ERC20 used by the protocol              |       🖊️             |
| Test coverage                           | ✅ SCOUTS: Please populate this after running the test coverage command                          |
| ERC721 used  by the protocol            |            🖊️              |
| ERC777 used by the protocol             |           🖊️                |
| ERC1155 used by the protocol            |              🖊️            |
| Chains the protocol will be deployed on | Ethereum,Arbitrum,Base,Optimism,Polygon,OtherSonic  |

### ERC20 token behaviors in scope

| Question                                                                                                                                                   | Answer |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------- | ------ |
| [Missing return values](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#missing-return-values)                                                      |   In scope  |
| [Fee on transfer](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#fee-on-transfer)                                                                  |  Out of scope  |
| [Balance changes outside of transfers](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#balance-modifications-outside-of-transfers-rebasingairdrops) | Out of scope    |
| [Upgradeability](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#upgradable-tokens)                                                                 |   Out of scope  |
| [Flash minting](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#flash-mintable-tokens)                                                              | Out of scope    |
| [Pausability](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#pausable-tokens)                                                                      | Out of scope    |
| [Approval race protections](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#approval-race-protections)                                              | Out of scope    |
| [Revert on approval to zero address](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#revert-on-approval-to-zero-address)                            | In scope    |
| [Revert on zero value approvals](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#revert-on-zero-value-approvals)                                    | In scope    |
| [Revert on zero value transfers](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#revert-on-zero-value-transfers)                                    | In scope    |
| [Revert on transfer to the zero address](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#revert-on-transfer-to-the-zero-address)                    | In scope    |
| [Revert on large approvals and/or transfers](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#revert-on-large-approvals--transfers)                  | In scope    |
| [Doesn't revert on failure](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#no-revert-on-failure)                                                   |  In scope   |
| [Multiple token addresses](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#revert-on-zero-value-transfers)                                          | Out of scope    |
| [Low decimals ( < 6)](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#low-decimals)                                                                 |   In scope  |
| [High decimals ( > 18)](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#high-decimals)                                                              | Out of scope    |
| [Blocklists](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#tokens-with-blocklists)                                                                | Out of scope    |

### External integrations (e.g., Uniswap) behavior in scope:


| Question                                                  | Answer |
| --------------------------------------------------------- | ------ |
| Enabling/disabling fees (e.g. Blur disables/enables fees) | Yes   |
| Pausability (e.g. Uniswap pool gets paused)               |  Yes   |
| Upgradeability (e.g. Uniswap gets upgraded)               |   No  |


### EIP compliance checklist
silo-vaults/contracts/SiloVault.sol implements ERC4626
silo-vaults/contracts/IdleVault.sol implements ERC4626

✅ SCOUTS: Please format the response above 👆 using the template below👇

| Question                                | Answer                       |
| --------------------------------------- | ---------------------------- |
| src/Token.sol                           | ERC20, ERC721                |
| src/NFT.sol                             | ERC721                       |


# Additional context

## Main invariants

https://github.com/silo-finance/silo-contracts-v2/tree/develop/certora/specs/vaults

✅ SCOUTS: Please format the response above 👆 so its not a wall of text and its readable.

## Attack ideas (where to focus for bugs)
Forked code: SiloVault is a fork of MorphoVault. Original code only supported deploying capital to Morpho protocol while SiloVault was changed to support any ERC4626 vault and highly configurable rewards. Admin role stayed unchanged. New admin function were added to manage rewards setup. It is a good start to make sure that code integrity is kept and no bugs were introduced during forking.

Rewards: SiloVault supports custom rewards distribution. It is important that rewards do not compromise the SiloVault logic in any way and are distributed correctly.



✅ SCOUTS: Please format the response above 👆 so its not a wall of text and its readable.

## All trusted roles in the protocol

- Owner
- Guardian
- Allocator

Same as MorphoVault with addition to new privileges for owner to manage the rewards. For details, see Morpho docs.



✅ SCOUTS: Please format the response above 👆 using the template below👇

| Role                                | Description                       |
| --------------------------------------- | ---------------------------- |
| Owner                          | Has superpowers                |
| Administrator                             | Can change fees                       |

## Describe any novel or unique curve logic or mathematical models implemented in the contracts:

N/A

✅ SCOUTS: Please format the response above 👆 so its not a wall of text and its readable.

## Running tests

See docs: https://github.com/silo-finance/silo-contracts-v2/blob/develop/MOREDOCS.md 

✅ SCOUTS: Please format the response above 👆 using the template below👇

```bash
git clone https://github.com/code-423n4/2023-08-arbitrum
git submodule update --init --recursive
cd governance
foundryup
make install
make build
make sc-election-test
```
To run code coverage
```bash
make coverage
```
To run gas benchmarks
```bash
make gas
```

✅ SCOUTS: Add a screenshot of your terminal showing the gas report
✅ SCOUTS: Add a screenshot of your terminal showing the test coverage


# Scope

*See [scope.txt](https://github.com/code-423n4/2025-03-silo-finance/blob/main/scope.txt)*

### Files in scope


| File   | Logic Contracts | Interfaces | nSLOC | Purpose | Libraries used |
| ------ | --------------- | ---------- | ----- | -----   | ------------ |
| /silo-vaults/contracts/IdleVault.sol | 1| **** | 33 | |openzeppelin5/token/ERC20/extensions/ERC4626.sol<br>openzeppelin5/interfaces/IERC4626.sol|
| /silo-vaults/contracts/IdleVaultsFactory.sol | 1| **** | 22 | |openzeppelin5/proxy/Clones.sol<br>openzeppelin5/interfaces/IERC4626.sol|
| /silo-vaults/contracts/PublicAllocator.sol | 1| **** | 90 | |openzeppelin5/interfaces/IERC4626.sol<br>morpho-blue/libraries/UtilsLib.sol<br>silo-core/contracts/lib/RevertLib.sol|
| /silo-vaults/contracts/SiloVault.sol | 1| **** | 554 | |openzeppelin5/utils/math/SafeCast.sol<br>openzeppelin5/token/ERC20/extensions/ERC4626.sol<br>openzeppelin5/interfaces/IERC4626.sol<br>openzeppelin5/access/Ownable2Step.sol<br>openzeppelin5/token/ERC20/extensions/ERC20Permit.sol<br>openzeppelin5/utils/Multicall.sol<br>openzeppelin5/token/ERC20/ERC20.sol<br>openzeppelin5/token/ERC20/utils/SafeERC20.sol<br>morpho-blue/libraries/UtilsLib.sol<br>silo-core/contracts/lib/TokenHelper.sol|
| /silo-vaults/contracts/SiloVaultsFactory.sol | 1| **** | 37 | |openzeppelin5/proxy/Clones.sol|
| /silo-vaults/contracts/incentives/VaultIncentivesModule.sol | 1| **** | 106 | |openzeppelin5-upgradeable/access/Ownable2StepUpgradeable.sol<br>openzeppelin5/utils/structs/EnumerableSet.sol<br>openzeppelin5/interfaces/IERC4626.sol<br>silo-vaults/contracts/interfaces/ISiloVault.sol|
| /silo-vaults/contracts/incentives/claiming-logics/SiloIncentivesControllerCL.sol | 1| **** | 25 | |silo-core/contracts/incentives/interfaces/ISiloIncentivesController.sol|
| /silo-vaults/contracts/incentives/claiming-logics/SiloIncentivesControllerCLFactory.sol | 1| **** | 11 | ||
| /silo-vaults/contracts/interfaces/IIncentivesClaimingLogic.sol | ****| 1 | 5 | ||
| /silo-vaults/contracts/interfaces/INotificationReceiver.sol | ****| 1 | 3 | ||
| /silo-vaults/contracts/interfaces/IPublicAllocator.sol | ****| 3 | 20 | |openzeppelin5/interfaces/IERC4626.sol|
| /silo-vaults/contracts/interfaces/ISiloIncentivesControllerCLFactory.sol | ****| 1 | 5 | ||
| /silo-vaults/contracts/interfaces/ISiloVault.sol | ****| 5 | 15 | |openzeppelin5/token/ERC20/extensions/ERC20Permit.sol<br>openzeppelin5/interfaces/IERC4626.sol|
| /silo-vaults/contracts/interfaces/ISiloVaultsFactory.sol | ****| 1 | 4 | ||
| /silo-vaults/contracts/interfaces/IVaultIncentivesModule.sol | ****| 1 | 23 | |openzeppelin5/interfaces/IERC4626.sol|
| /silo-vaults/contracts/libraries/ConstantsLib.sol | 1| **** | 7 | ||
| /silo-vaults/contracts/libraries/ErrorsLib.sol | 1| **** | 52 | |openzeppelin5/interfaces/IERC4626.sol|
| /silo-vaults/contracts/libraries/EventsLib.sol | 1| **** | 64 | |openzeppelin5/interfaces/IERC4626.sol|
| /silo-vaults/contracts/libraries/PendingLib.sol | 1| **** | 24 | ||
| /silo-vaults/contracts/libraries/SiloVaultActionsLib.sol | 1| **** | 43 | |openzeppelin5/interfaces/IERC4626.sol<br>morpho-blue/libraries/UtilsLib.sol<br>openzeppelin5/token/ERC20/utils/SafeERC20.sol|
| /silo-core/contracts/incentives/SiloIncentivesController.sol | 1| **** | 78 | |openzeppelin5/token/ERC20/utils/SafeERC20.sol<br>openzeppelin5/token/ERC20/IERC20.sol<br>openzeppelin5/utils/structs/EnumerableSet.sol<br>openzeppelin5/utils/Strings.sol|
| /silo-core/contracts/incentives/SiloIncentivesControllerFactory.sol | 1| **** | 11 | ||
| /silo-core/contracts/incentives/SiloIncentivesControllerGaugeLike.sol | 1| **** | 44 | |openzeppelin5/token/ERC20/IERC20.sol|
| /silo-core/contracts/incentives/SiloIncentivesControllerGaugeLikeFactory.sol | 1| **** | 11 | ||
| /silo-core/contracts/incentives/base/BaseIncentivesController.sol | 1| **** | 159 | |openzeppelin5/token/ERC20/IERC20.sol<br>openzeppelin5/token/ERC20/utils/SafeERC20.sol<br>openzeppelin5/utils/structs/EnumerableSet.sol|
| /silo-core/contracts/incentives/base/DistributionManager.sol | 1| **** | 162 | |openzeppelin5/token/ERC20/IERC20.sol<br>openzeppelin5/token/ERC20/extensions/IERC20Metadata.sol<br>openzeppelin5/utils/math/Math.sol<br>openzeppelin5/access/Ownable2Step.sol<br>openzeppelin5/utils/structs/EnumerableSet.sol|
| /silo-core/contracts/incentives/interfaces/IDistributionManager.sol | ****| 1 | 34 | ||
| /silo-core/contracts/incentives/interfaces/ISiloIncentivesController.sol | ****| 1 | 28 | ||
| /silo-core/contracts/incentives/interfaces/ISiloIncentivesControllerFactory.sol | ****| 1 | 4 | ||
| /silo-core/contracts/incentives/interfaces/ISiloIncentivesControllerGaugeLikeFactory.sol | ****| 1 | 4 | ||
| /silo-core/contracts/incentives/lib/DistributionTypes.sol | 1| **** | 19 | ||
| **Totals** | **20** | **17** | **1697** | | |

### Files out of scope

*See [out_of_scope.txt](https://github.com/code-423n4/2025-03-silo-finance/blob/main/out_of_scope.txt)*

| File         |
| ------------ |
| ./certora/harness/MathLibCaller.sol |
| ./certora/harness/SiloHarness.sol |
| ./certora/harness/silo0/ShareCollateralToken0.sol |
| ./certora/harness/silo0/ShareDebtToken0.sol |
| ./certora/harness/silo0/ShareProtectedCollateralToken0.sol |
| ./certora/harness/silo0/Silo0.sol |
| ./certora/harness/silo1/ShareCollateralToken1.sol |
| ./certora/harness/silo1/ShareDebtToken1.sol |
| ./certora/harness/silo1/ShareProtectedCollateralToken1.sol |
| ./certora/harness/silo1/Silo1.sol |
| ./certora/harness/vaults/ERC20Helper.sol |
| ./certora/harness/vaults/MetaMorphoHarness.sol |
| ./certora/mocks/EmptyHookReceiver.sol |
| ./certora/mocks/Token0.sol |
| ./certora/mocks/Token1.sol |
| ./certora/mocks/vaults/Token0.sol |
| ./certora/mocks/vaults/Vault0.sol |
| ./common/addresses/AddrKey.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/distributors/IDistributorCallback.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/IArbitrumFeeProvider.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/IAuthorizerAdaptor.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/IAuthorizerAdaptorEntrypoint.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/IBalancerMinter.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/IBalancerToken.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/IBalancerTokenAdmin.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/IChildChainGauge.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/IChildChainLiquidityGaugeFactory.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/IChildChainStreamer.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/IFeeDistributor.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/IGaugeAdder.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/IGaugeController.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/IL2GaugeCheckpointer.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/IL2LayerZeroDelegation.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/ILMGetters.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/ILiquidityGauge.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/ILiquidityGaugeFactory.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/IMainnetBalancerMinter.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/IOmniVotingEscrow.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/IOmniVotingEscrowAdaptor.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/IOmniVotingEscrowAdaptorSettings.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/IOptimismGasLimitProvider.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/IRewardTokenDistributor.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/IRewardsOnlyGauge.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/ISmartWalletChecker.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/IStakelessGauge.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/IStakingLiquidityGauge.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/IVeDelegation.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/IVotingEscrow.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/liquidity-mining/IVotingEscrowRemapper.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/pool-linear/IERC4626.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/pool-linear/ILinearPool.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/pool-stable/IComposableStablePoolRates.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/pool-stable/StablePoolUserData.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/pool-utils/BasePoolUserData.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/pool-utils/IBasePoolController.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/pool-utils/IBasePoolFactory.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/pool-utils/IControlledPool.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/pool-utils/IFactoryCreatedPoolVersion.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/pool-utils/ILastCreatedPoolFactory.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/pool-utils/IManagedPool.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/pool-utils/IPoolVersion.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/pool-utils/IProtocolFeeCache.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/pool-utils/IRateProvider.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/pool-utils/IRateProviderPool.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/pool-utils/IRecoveryMode.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/pool-utils/IRecoveryModeHelper.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/pool-utils/IVersion.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/pool-weighted/IExternalWeightedMath.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/pool-weighted/WeightedPoolUserData.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/solidity-utils/helpers/BalancerErrors.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/solidity-utils/helpers/IAuthentication.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/solidity-utils/helpers/IOptionalOnlyCaller.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/solidity-utils/helpers/ISignaturesValidator.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/solidity-utils/helpers/ITemporarilyPausable.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/solidity-utils/misc/IERC4626.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/solidity-utils/misc/IWETH.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/standalone-utils/IAToken.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/standalone-utils/IBALTokenHolder.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/standalone-utils/IBALTokenHolderFactory.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/standalone-utils/IBalancerQueries.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/standalone-utils/IBalancerRelayer.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/standalone-utils/IButtonWrapper.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/standalone-utils/ICToken.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/standalone-utils/IEulerToken.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/standalone-utils/IGearboxDieselToken.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/standalone-utils/IProtocolFeePercentagesProvider.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/standalone-utils/IProtocolFeeSplitter.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/standalone-utils/IProtocolFeesWithdrawer.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/standalone-utils/IProtocolIdRegistry.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/standalone-utils/IReaperTokenVault.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/standalone-utils/IShareToken.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/standalone-utils/ISilo.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/standalone-utils/IStaticATokenLM.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/standalone-utils/ITetuSmartVault.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/standalone-utils/ITetuStrategy.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/standalone-utils/IUnbuttonToken.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/standalone-utils/IYearnTokenVault.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/standalone-utils/IstETH.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/standalone-utils/IwstETH.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/vault/IAsset.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/vault/IAuthorizer.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/vault/IBasePool.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/vault/IBasicAuthorizer.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/vault/IFlashLoanRecipient.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/vault/IGeneralPool.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/vault/IMinimalSwapInfoPool.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/vault/IPoolSwapStructs.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/vault/IProtocolFeesCollector.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/vault/ITimelockAuthorizer.sol |
| ./external/balancer-v2-monorepo/pkg/interfaces/contracts/vault/IVault.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/BalancerMinter.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/BalancerTokenAdmin.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/L2BalancerPseudoMinter.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/L2LayerZeroBridgeForwarder.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/MainnetBalancerMinter.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/NullVotingEscrow.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/SmartWalletChecker.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/VotingEscrowDelegationProxy.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/VotingEscrowRemapper.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/admin/AuthorizerAdaptor.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/admin/AuthorizerAdaptorEntrypoint.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/admin/ChildChainGaugeTokenAdder.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/admin/DistributionScheduler.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/admin/GaugeAdder.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/fee-distribution/FeeDistributor.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/gauges/BaseGaugeFactory.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/gauges/ChildChainGaugeFactory.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/gauges/ChildChainGaugeRewardHelper.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/gauges/ChildChainLiquidityGaugeFactory.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/gauges/L2GaugeCheckpointer.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/gauges/StakelessGauge.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/gauges/arbitrum/ArbitrumRootGauge.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/gauges/arbitrum/ArbitrumRootGaugeFactory.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/gauges/arbitrum/IGatewayRouter.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/gauges/ethereum/LiquidityGaugeFactory.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/gauges/ethereum/SingleRecipientGauge.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/gauges/ethereum/SingleRecipientGaugeFactory.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/gauges/gnosis/GnosisRootGauge.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/gauges/gnosis/GnosisRootGaugeFactory.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/gauges/optimism/OptimismRootGauge.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/gauges/optimism/OptimismRootGaugeFactory.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/gauges/polygon/PolygonRootGauge.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/gauges/polygon/PolygonRootGaugeFactory.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/test/MockBalancerMinter.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/test/MockBalancerTokenAdmin.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/test/MockChildChainGauge.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/test/MockGaugeController.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/test/MockL2LayerZeroDelegation.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/test/MockLiquidityGauge.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/test/MockLiquidityGaugeFactory.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/test/MockOmniVotingEscrow.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/test/MockPaymentReceiver.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/test/MockRewardTokenDistributor.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/test/MockVeDelegation.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/test/MockVotingEscrow.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/test/TestAccessControl.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/test/TestBalancerToken.sol |
| ./external/balancer-v2-monorepo/pkg/liquidity-mining/contracts/test/TestFeeDistributor.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/BalancerPoolToken.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/BaseGeneralPool.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/BaseMinimalSwapInfoPool.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/BasePool.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/BasePoolAuthorization.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/NewBasePool.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/RecoveryMode.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/RecoveryModeHelper.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/Version.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/external-fees/ExternalAUMFees.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/external-fees/ExternalFees.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/external-fees/InvariantGrowthProtocolSwapFees.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/external-fees/ProtocolFeeCache.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/factories/BasePoolFactory.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/factories/FactoryWidePauseWindow.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/lib/BasePoolMath.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/lib/ComposablePoolLib.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/lib/ExternalCallLib.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/lib/PoolRegistrationLib.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/lib/VaultReentrancyLib.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/rates/PriceRateCache.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/test/MaliciousQueryReverter.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/test/MockBalancerPoolToken.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/test/MockBasePool.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/test/MockExternalAUMFees.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/test/MockExternalCaller.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/test/MockExternalFees.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/test/MockFactoryCreatedPool.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/test/MockFailureModes.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/test/MockInvariantGrowthProtocolSwapFees.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/test/MockNewBasePool.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/test/MockPoolFactory.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/test/MockPoolRegistrationLib.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/test/MockPriceRateCache.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/test/MockProtocolFeeCache.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/test/MockRateProvider.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/test/MockRecoveryModeStorage.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/test/MockReentrancyPool.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/contracts/test/MockVault.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/test/foundry/BasePoolMath.t.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/test/foundry/ComposablePoolLib.t.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/test/foundry/ExternalFees.t.sol |
| ./external/balancer-v2-monorepo/pkg/pool-utils/test/foundry/PoolRegistrationLib.t.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/helpers/Authentication.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/helpers/BaseSplitCodeFactory.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/helpers/CodeDeployer.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/helpers/EOASignaturesValidator.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/helpers/ERC20Helpers.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/helpers/ExtraCalldataEOASignaturesValidator.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/helpers/InputHelpers.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/helpers/OptionalOnlyCaller.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/helpers/ScalingHelpers.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/helpers/SignaturesValidator.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/helpers/SingletonAuthentication.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/helpers/TemporarilyPausable.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/helpers/VaultHelpers.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/helpers/WordCodec.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/helpers/WordCodecHelpers.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/math/FixedPoint.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/math/LogExpMath.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/math/Math.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/test/BalancerErrorsMock.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/test/BreakableERC20Mock.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/test/BrokenERC20Mock.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/test/CodeDeployerFactory.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/test/EOASignaturesValidatorMock.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/test/ERC1271Mock.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/test/ERC20FalseApprovalMock.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/test/ERC20Mock.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/test/ERC20PermitMock.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/test/EnumerableMapMock.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/test/ExtraCalldataEOASignaturesValidatorMock.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/test/FixedPointMock.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/test/LogExpMathMock.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/test/MathMock.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/test/MockScalingHelpers.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/test/MockSplitCodeFactory.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/test/MockWordCodec.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/test/OptionalOnlyCallerMock.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/test/ReentrancyAttack.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/test/ReentrancyMock.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/test/SafeERC20Mock.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/test/SignaturesValidatorMock.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/test/SingletonAuthenticationMock.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/test/TemporarilyPausableMock.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/test/TestToken.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/contracts/test/USDTMock.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/test/foundry/FixedPoint.t.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/test/foundry/InputHelpers.t.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/test/foundry/Math.t.sol |
| ./external/balancer-v2-monorepo/pkg/solidity-utils/test/foundry/WordCodec.t.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/BALTokenHolder.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/BALTokenHolderFactory.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/BalancerQueries.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/BatchRelayerLibrary.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/PoolRecoveryHelper.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/ProtocolFeePercentagesProvider.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/ProtocolFeeSplitter.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/ProtocolFeesWithdrawer.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/ProtocolIdRegistry.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/relayer/AaveWrapping.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/relayer/BalancerRelayer.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/relayer/BaseRelayerLibrary.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/relayer/CompoundV2Wrapping.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/relayer/ERC4626Wrapping.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/relayer/EulerWrapping.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/relayer/GaugeActions.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/relayer/GearboxWrapping.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/relayer/IBaseRelayerLibrary.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/relayer/LidoWrapping.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/relayer/ReaperWrapping.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/relayer/SiloWrapping.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/relayer/TetuWrapping.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/relayer/UnbuttonWrapping.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/relayer/VaultActions.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/relayer/VaultPermit.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/relayer/YearnWrapping.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/relayer/interfaces/IMockEulerProtocol.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/relayer/special/DoubleEntrypointFixRelayer.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/test/MockAaveAMPLToken.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/test/MockBaseRelayerLibrary.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/test/MockBatchRelayerLibrary.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/test/MockCToken.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/test/MockEulerProtocol.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/test/MockEulerToken.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/test/MockGearboxDieselToken.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/test/MockGearboxVault.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/test/MockReaperVault.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/test/MockRecoveryRateProviderPool.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/test/MockRecoveryRateProviderPoolFactory.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/test/MockRevertingRateProvider.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/test/MockShareToken.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/test/MockSilo.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/test/MockStETH.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/test/MockStaticATokenLM.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/test/MockTetuShareValueHelper.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/test/MockTetuSmartVault.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/test/MockTetuStrategy.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/test/MockUnbuttonERC20.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/test/MockWstETH.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/test/MockYearnTokenVault.sol |
| ./external/balancer-v2-monorepo/pkg/standalone-utils/contracts/test/TestWETH.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/AssetHelpers.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/AssetManagers.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/AssetTransfersHandler.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/Fees.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/FlashLoans.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/PoolBalances.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/PoolRegistry.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/PoolTokens.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/ProtocolFeesCollector.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/Swaps.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/UserBalance.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/Vault.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/VaultAuthorization.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/authorizer/AuthorizerWithAdaptorValidation.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/authorizer/TimelockAuthorizer.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/authorizer/TimelockAuthorizerManagement.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/authorizer/TimelockExecutionHelper.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/balances/BalanceAllocation.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/balances/GeneralPoolsBalance.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/balances/MinimalSwapInfoPoolsBalance.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/balances/TwoTokenPoolsBalance.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/test/BalanceAllocationMock.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/test/EthForceSender.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/test/MockAssetTransfersHandler.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/test/MockAuthenticatedContract.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/test/MockAuthorizerAdaptorEntrypoint.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/test/MockBasicAuthorizer.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/test/MockFlashLoanRecipient.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/test/MockInternalBalanceRelayer.sol |
| ./external/balancer-v2-monorepo/pkg/vault/contracts/test/MockPool.sol |
| ./proposals/contracts/Proposal.sol |
| ./proposals/contracts/ProposalEngine.sol |
| ./proposals/contracts/ProposalEngineLib.sol |
| ./proposals/contracts/Proposer.sol |
| ./proposals/contracts/TwoStepOwnableProposer.sol |
| ./proposals/contracts/interfaces/IProposal.sol |
| ./proposals/contracts/interfaces/IProposalEngine.sol |
| ./proposals/contracts/proposers/ve-silo/BalancerTokenAdminProposer.sol |
| ./proposals/contracts/proposers/ve-silo/CCIPGaugeCheckpointerProposer.sol |
| ./proposals/contracts/proposers/ve-silo/FeeDistributorProposer.sol |
| ./proposals/contracts/proposers/ve-silo/GaugeAdderProposer.sol |
| ./proposals/contracts/proposers/ve-silo/GaugeControllerProposer.sol |
| ./proposals/contracts/proposers/ve-silo/LiquidityGaugeFactoryProposer.sol |
| ./proposals/contracts/proposers/ve-silo/SiloFactoryProposer.sol |
| ./proposals/contracts/proposers/ve-silo/SmartWalletCheckerProposer.sol |
| ./proposals/contracts/proposers/ve-silo/StakelessGaugeCheckpointerAdaptorProposer.sol |
| ./proposals/contracts/proposers/ve-silo/VeSiloDelegatorViaCCIPProposer.sol |
| ./proposals/contracts/proposers/ve-silo/VotingEscrowCCIPRemapperProposer.sol |
| ./proposals/contracts/proposers/ve-silo/VotingEscrowDelegationProxyProposer.sol |
| ./proposals/sip/_common/Constants.sol |
| ./proposals/sip/sip-v2-init/SIPV2Init.sol |
| ./silo-core/common/SiloCoreContracts.sol |
| ./silo-core/contracts/Silo.sol |
| ./silo-core/contracts/SiloConfig.sol |
| ./silo-core/contracts/SiloDeployer.sol |
| ./silo-core/contracts/SiloFactory.sol |
| ./silo-core/contracts/SiloLens.sol |
| ./silo-core/contracts/interestRateModel/InterestRateModelV2.sol |
| ./silo-core/contracts/interestRateModel/InterestRateModelV2Config.sol |
| ./silo-core/contracts/interestRateModel/InterestRateModelV2Factory.sol |
| ./silo-core/contracts/interfaces/ICrossReentrancyGuard.sol |
| ./silo-core/contracts/interfaces/IERC20R.sol |
| ./silo-core/contracts/interfaces/IERC3156FlashBorrower.sol |
| ./silo-core/contracts/interfaces/IERC3156FlashLender.sol |
| ./silo-core/contracts/interfaces/IGaugeHookReceiver.sol |
| ./silo-core/contracts/interfaces/IGaugeLike.sol |
| ./silo-core/contracts/interfaces/IHookReceiver.sol |
| ./silo-core/contracts/interfaces/IInterestRateModel.sol |
| ./silo-core/contracts/interfaces/IInterestRateModelV2.sol |
| ./silo-core/contracts/interfaces/IInterestRateModelV2Config.sol |
| ./silo-core/contracts/interfaces/IInterestRateModelV2Factory.sol |
| ./silo-core/contracts/interfaces/ILiquidationHelper.sol |
| ./silo-core/contracts/interfaces/IPartialLiquidation.sol |
| ./silo-core/contracts/interfaces/IShareToken.sol |
| ./silo-core/contracts/interfaces/IShareTokenInitializable.sol |
| ./silo-core/contracts/interfaces/ISilo.sol |
| ./silo-core/contracts/interfaces/ISiloConfig.sol |
| ./silo-core/contracts/interfaces/ISiloDeployer.sol |
| ./silo-core/contracts/interfaces/ISiloERC20.sol |
| ./silo-core/contracts/interfaces/ISiloFactory.sol |
| ./silo-core/contracts/interfaces/ISiloHookV1.sol |
| ./silo-core/contracts/interfaces/ISiloLens.sol |
| ./silo-core/contracts/interfaces/ISiloOracle.sol |
| ./silo-core/contracts/interfaces/ISiloRouter.sol |
| ./silo-core/contracts/interfaces/ISiloRouterImplementation.sol |
| ./silo-core/contracts/interfaces/IWrappedNativeToken.sol |
| ./silo-core/contracts/lib/Actions.sol |
| ./silo-core/contracts/lib/CallBeforeQuoteLib.sol |
| ./silo-core/contracts/lib/CloneDeterministic.sol |
| ./silo-core/contracts/lib/ERC20RStorageLib.sol |
| ./silo-core/contracts/lib/Hook.sol |
| ./silo-core/contracts/lib/IsContract.sol |
| ./silo-core/contracts/lib/NonReentrantLib.sol |
| ./silo-core/contracts/lib/PRBMathCommon.sol |
| ./silo-core/contracts/lib/PRBMathSD59x18.sol |
| ./silo-core/contracts/lib/RevertLib.sol |
| ./silo-core/contracts/lib/Rounding.sol |
| ./silo-core/contracts/lib/ShareCollateralTokenLib.sol |
| ./silo-core/contracts/lib/ShareTokenLib.sol |
| ./silo-core/contracts/lib/SiloERC4626Lib.sol |
| ./silo-core/contracts/lib/SiloLendingLib.sol |
| ./silo-core/contracts/lib/SiloLensLib.sol |
| ./silo-core/contracts/lib/SiloMathLib.sol |
| ./silo-core/contracts/lib/SiloSolvencyLib.sol |
| ./silo-core/contracts/lib/SiloStdLib.sol |
| ./silo-core/contracts/lib/SiloStorageLib.sol |
| ./silo-core/contracts/lib/TokenHelper.sol |
| ./silo-core/contracts/lib/Views.sol |
| ./silo-core/contracts/silo-router/SiloRouter.sol |
| ./silo-core/contracts/silo-router/SiloRouterImplementation.sol |
| ./silo-core/contracts/utils/CrossReentrancyGuard.sol |
| ./silo-core/contracts/utils/ShareCollateralToken.sol |
| ./silo-core/contracts/utils/ShareDebtToken.sol |
| ./silo-core/contracts/utils/ShareProtectedCollateralToken.sol |
| ./silo-core/contracts/utils/ShareToken.sol |
| ./silo-core/contracts/utils/TokenRescuer.sol |
| ./silo-core/contracts/utils/Tower.sol |
| ./silo-core/contracts/utils/hook-receivers/SiloHookV1.sol |
| ./silo-core/contracts/utils/hook-receivers/_common/BaseHookReceiver.sol |
| ./silo-core/contracts/utils/hook-receivers/gauge/GaugeHookReceiver.sol |
| ./silo-core/contracts/utils/hook-receivers/liquidation/PartialLiquidation.sol |
| ./silo-core/contracts/utils/hook-receivers/liquidation/lib/PartialLiquidationExecLib.sol |
| ./silo-core/contracts/utils/hook-receivers/liquidation/lib/PartialLiquidationLib.sol |
| ./silo-core/contracts/utils/liquidationHelper/DexSwap.sol |
| ./silo-core/contracts/utils/liquidationHelper/LiquidationHelper.sol |
| ./silo-core/contracts/utils/liquidationHelper/ManualLiquidationHelper.sol |
| ./silo-core/deploy/InterestRateModelV2Deploy.s.sol |
| ./silo-core/deploy/InterestRateModelV2FactoryDeploy.s.sol |
| ./silo-core/deploy/LiquidationHelperDeploy.s.sol |
| ./silo-core/deploy/MainnetDeploy.s.sol |
| ./silo-core/deploy/ManualLiquidationHelperDeploy.s.sol |
| ./silo-core/deploy/SiloDeployerDeploy.s.sol |
| ./silo-core/deploy/SiloFactoryDeploy.s.sol |
| ./silo-core/deploy/SiloHookV1Deploy.s.sol |
| ./silo-core/deploy/SiloIncentivesControllerFactoryDeploy.s.sol |
| ./silo-core/deploy/SiloIncentivesControllerGaugeLikeFactoryDeploy.sol |
| ./silo-core/deploy/SiloLensDeploy.s.sol |
| ./silo-core/deploy/SiloRouterDeploy.s.sol |
| ./silo-core/deploy/TowerDeploy.s.sol |
| ./silo-core/deploy/TowerRegistration.s.sol |
| ./silo-core/deploy/_CommonDeploy.sol |
| ./silo-core/deploy/incentives-controller/SiloIncentivesControllerGLCreate.s.sol |
| ./silo-core/deploy/incentives-controller/SiloIncentivesControllerGLCreateAndConfigure.s.sol |
| ./silo-core/deploy/incentives-controller/SiloIncentivesControllerGLDeployments.sol |
| ./silo-core/deploy/input-readers/InterestRateModelConfigData.sol |
| ./silo-core/deploy/input-readers/SiloConfigData.sol |
| ./silo-core/deploy/silo/PrintSiloAddresses.s.sol |
| ./silo-core/deploy/silo/SiloDeploy.s.sol |
| ./silo-core/deploy/silo/SiloDeployWithDeployerOwner.s.sol |
| ./silo-core/deploy/silo/SiloDeployWithGaugeHookReceiver.s.sol |
| ./silo-core/deploy/silo/SiloDeployWithHookReceiverOwner.s.sol |
| ./silo-core/deploy/silo/SiloDeployWithIncentives.s.sol |
| ./silo-core/deploy/silo/SiloDeployments.sol |
| ./silo-core/deploy/silo/VerifySilo.s.sol |
| ./silo-core/deploy/silo/verifier/Logger.sol |
| ./silo-core/deploy/silo/verifier/SiloVerifier.sol |
| ./silo-core/deploy/silo/verifier/Utils.sol |
| ./silo-core/deploy/silo/verifier/checks/ICheck.sol |
| ./silo-core/deploy/silo/verifier/checks/behavior/CheckExternalPrices.sol |
| ./silo-core/deploy/silo/verifier/checks/behavior/CheckPriceDoesNotReturnZero.sol |
| ./silo-core/deploy/silo/verifier/checks/behavior/CheckQuoteIsLinearFunction.sol |
| ./silo-core/deploy/silo/verifier/checks/behavior/CheckQuoteLargeAmounts.sol |
| ./silo-core/deploy/silo/verifier/checks/silo/CheckDaoFee.sol |
| ./silo-core/deploy/silo/verifier/checks/silo/CheckDeployerFee.sol |
| ./silo-core/deploy/silo/verifier/checks/silo/CheckFlashloanFee.sol |
| ./silo-core/deploy/silo/verifier/checks/silo/CheckHookOwner.sol |
| ./silo-core/deploy/silo/verifier/checks/silo/CheckIncentivesOwner.sol |
| ./silo-core/deploy/silo/verifier/checks/silo/CheckIrmConfig.sol |
| ./silo-core/deploy/silo/verifier/checks/silo/CheckLiquidationFee.sol |
| ./silo-core/deploy/silo/verifier/checks/silo/CheckMaxLtvLtLiquidationFee.sol |
| ./silo-core/deploy/silo/verifier/checks/silo/CheckShareTokensInGauge.sol |
| ./silo-core/deploy/silo/verifier/checks/silo/CheckSiloImplementation.sol |
| ./silo-core/test/echidna/EchidnaE2E.sol |
| ./silo-core/test/echidna/EchidnaIRMv2.sol |
| ./silo-core/test/echidna/EchidnaPRBMath.sol |
| ./silo-core/test/echidna/EchidnaSiloERC4626.sol |
| ./silo-core/test/echidna/data/Data.sol |
| ./silo-core/test/echidna/internal_testing/SiloInternal.sol |
| ./silo-core/test/echidna/utils/Actor.sol |
| ./silo-core/test/echidna/utils/Deployers.sol |
| ./silo-core/test/echidna/utils/VyperDeployer.sol |
| ./silo-core/test/foundry/PublicTutorials/1_TutorialCheckPosition.t.sol |
| ./silo-core/test/foundry/PublicTutorials/2_TutorialCreatePosition.t.sol |
| ./silo-core/test/foundry/PublicTutorials/3_TutorialMarketInfo.t.sol |
| ./silo-core/test/foundry/Silo/SiloPocTest.t.sol |
| ./silo-core/test/foundry/Silo/borrow/Borrow.i.sol |
| ./silo-core/test/foundry/Silo/borrow/BorrowAllowance.i.sol |
| ./silo-core/test/foundry/Silo/borrow/BorrowNotPossible.i.sol |
| ./silo-core/test/foundry/Silo/borrow/BorrowSameAsset.i.sol |
| ./silo-core/test/foundry/Silo/deploy/SiloDeploy.i.sol |
| ./silo-core/test/foundry/Silo/deploy/SiloDeployValidation.u.sol |
| ./silo-core/test/foundry/Silo/deposit/Deposit.i.sol |
| ./silo-core/test/foundry/Silo/deposit/Mint.i.sol |
| ./silo-core/test/foundry/Silo/flashloan/Flashloan.i.sol |
| ./silo-core/test/foundry/Silo/flashloan/FlashloanProtected.i.sol |
| ./silo-core/test/foundry/Silo/getters/GetLiquidityAccrueInterestTest.i.sol |
| ./silo-core/test/foundry/Silo/getters/Getters.i.sol |
| ./silo-core/test/foundry/Silo/getters/IsSolvent.i.sol |
| ./silo-core/test/foundry/Silo/getters/RawLiquidityAndProtectedCollateral.i.sol |
| ./silo-core/test/foundry/Silo/hooks/SiloBeforeHooksTest.t.sol |
| ./silo-core/test/foundry/Silo/hooks/SiloHooks.i.sol |
| ./silo-core/test/foundry/Silo/hooks/SiloHooksActions.sol |
| ./silo-core/test/foundry/Silo/max/maxBorrow/MaxBorrow.i.sol |
| ./silo-core/test/foundry/Silo/max/maxBorrow/MaxBorrowNoLtv.i.sol |
| ./silo-core/test/foundry/Silo/max/maxBorrow/MaxBorrowShares.i.sol |
| ./silo-core/test/foundry/Silo/max/maxDeposit/MaxDeposit.i.sol |
| ./silo-core/test/foundry/Silo/max/maxDeposit/MaxMint.i.sol |
| ./silo-core/test/foundry/Silo/max/maxLiquidation/MaxLiquidation.i.sol |
| ./silo-core/test/foundry/Silo/max/maxLiquidation/MaxLiquidationCommon.sol |
| ./silo-core/test/foundry/Silo/max/maxLiquidation/MaxLiquidation_LTV100Full.i.sol |
| ./silo-core/test/foundry/Silo/max/maxLiquidation/MaxLiquidation_LTV100Full_withChunks.i.sol |
| ./silo-core/test/foundry/Silo/max/maxLiquidation/MaxLiquidation_LTV100Partial.i.sol |
| ./silo-core/test/foundry/Silo/max/maxLiquidation/MaxLiquidation_badDebt.i.sol |
| ./silo-core/test/foundry/Silo/max/maxLiquidation/MaxLiquidation_badDebt_withChunks.i.sol |
| ./silo-core/test/foundry/Silo/max/maxLiquidation/MaxLiquidation_cap.i.sol |
| ./silo-core/test/foundry/Silo/max/maxLiquidation/MaxLiquidation_whenDust.i.sol |
| ./silo-core/test/foundry/Silo/max/maxLiquidation/MaxLiquidation_whenDust_withChunks.i.sol |
| ./silo-core/test/foundry/Silo/max/maxLiquidation/MaxLiquidation_withChunks.i.sol |
| ./silo-core/test/foundry/Silo/max/maxRepay/MaxRepay.i.sol |
| ./silo-core/test/foundry/Silo/max/maxRepay/MaxRepayShares.i.sol |
| ./silo-core/test/foundry/Silo/max/maxWithdraw/MaxRedeem.i.sol |
| ./silo-core/test/foundry/Silo/max/maxWithdraw/MaxWithdraw.i.sol |
| ./silo-core/test/foundry/Silo/max/maxWithdraw/MaxWithdrawCommon.sol |
| ./silo-core/test/foundry/Silo/oracle/BeforeQuote.i.sol |
| ./silo-core/test/foundry/Silo/oracle/OracleThrows.i.sol |
| ./silo-core/test/foundry/Silo/overflow/TryCatchTest.t.sol |
| ./silo-core/test/foundry/Silo/preview/Preview.i.sol |
| ./silo-core/test/foundry/Silo/preview/PreviewDeposit.i.sol |
| ./silo-core/test/foundry/Silo/preview/PreviewMint.i.sol |
| ./silo-core/test/foundry/Silo/preview/previewBorrow/PreviewBorrow.i.sol |
| ./silo-core/test/foundry/Silo/preview/previewBorrow/PreviewBorrowSameAsset.i.sol |
| ./silo-core/test/foundry/Silo/preview/previewBorrow/PreviewBorrowSameAssetProtected.i.sol |
| ./silo-core/test/foundry/Silo/preview/previewBorrow/PreviewBorrowShares.i.sol |
| ./silo-core/test/foundry/Silo/preview/previewBorrow/PreviewBorrowSharesProtected.i.sol |
| ./silo-core/test/foundry/Silo/preview/previewRepay/PreviewRepay.i.sol |
| ./silo-core/test/foundry/Silo/preview/previewRepay/PreviewRepaySameAsset.i.sol |
| ./silo-core/test/foundry/Silo/preview/previewRepay/PreviewRepayShares.i.sol |
| ./silo-core/test/foundry/Silo/preview/previewRepay/PreviewRepaySharesSameAsset.i.sol |
| ./silo-core/test/foundry/Silo/preview/previewWithdraw/PreviewRedeem.i.sol |
| ./silo-core/test/foundry/Silo/preview/previewWithdraw/PreviewRedeemProtected.i.sol |
| ./silo-core/test/foundry/Silo/preview/previewWithdraw/PreviewRedeemProtectedSameAsset.i.sol |
| ./silo-core/test/foundry/Silo/preview/previewWithdraw/PreviewWithdraw.i.sol |
| ./silo-core/test/foundry/Silo/preview/previewWithdraw/PreviewWithdrawProtected.i.sol |
| ./silo-core/test/foundry/Silo/reentrancy/MaliciousToken.sol |
| ./silo-core/test/foundry/Silo/reentrancy/SiloReentrancy.t.sol |
| ./silo-core/test/foundry/Silo/reentrancy/TestState.sol |
| ./silo-core/test/foundry/Silo/reentrancy/interfaces/IMethodReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/interfaces/IMethodsRegistry.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/MethodReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/collateral-share-token/TransferFromReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/collateral-share-token/TransferReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/debt-share-token/DecreaseReceiveAllowanceReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/debt-share-token/IncreaseReceiveAllowanceReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/debt-share-token/ReceiveAllowanceReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/debt-share-token/SetReceiverApprovalReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/debt-share-token/TransferFromReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/debt-share-token/TransferReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/share-token/AllowanceReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/share-token/ApproveReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/share-token/BalanceOfAndTotalSupplyReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/share-token/BalanceOfReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/share-token/BurnReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/share-token/CallOnBehalfOfShareTokenReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/share-token/DecimalsReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/share-token/DomainSeparatorReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/share-token/Eip712DomainReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/share-token/ForwardTransferFromNoChecksReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/share-token/HookReceiverReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/share-token/HookSetupReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/share-token/InitializeReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/share-token/MintReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/share-token/NameReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/share-token/NoncesReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/share-token/PermitReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/share-token/SiloConfigReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/share-token/SiloReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/share-token/SymbolReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/share-token/SynchronizeHooksReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/share-token/TotalSupplyReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/share-token/_ShareTokenMethodReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/AccrueInterestForConfigReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/AccrueInterestReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/AllowanceReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/ApproveReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/AssetReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/BalanceOfAndTotalSupplyReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/BalanceOfReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/BorrowReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/BorrowSameAssetReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/BorrowSharesReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/BurnReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/CallOnBehalfOfSiloReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/ConfigReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/ConvertToAssetsReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/ConvertToAssetsWithTypeReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/ConvertToSharesReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/ConvertToSharesWithTypeReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/DecimalsReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/DepositReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/DepositWithTypeReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/DomainSeparatorReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/Eip712DomainReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/FactoryReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/FlashFeeReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/FlashLoanReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/ForwardTransferFromNoChecksTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/GetCollateralAndDebtTotalsStorageReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/GetCollateralAndProtectedTotalsStorageReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/GetCollateralAssetsReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/GetDebtAssetsReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/GetLiquidityReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/GetSiloStorageReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/GetTotalAssetsStorageReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/HookReceiverTokenReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/HookSetupReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/InitializeReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/IsSolventReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/MaxBorrowReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/MaxBorrowSameAssetReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/MaxBorrowSharesReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/MaxDepositReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/MaxDepositWithTypeReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/MaxFlashLoanReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/MaxMintReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/MaxMintWithTypeReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/MaxRedeemReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/MaxRedeemWithTypeReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/MaxRepayReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/MaxRepaySharesReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/MaxWithdrawReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/MaxWithdrawWithTypeReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/MintReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/MintTokenReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/MintWithTypeReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/NameReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/NoncesReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/PermitReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/PreviewBorrowReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/PreviewBorrowSharesReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/PreviewDepositReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/PreviewDepositWithTypeReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/PreviewMintReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/PreviewMintWithTypeReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/PreviewRedeemReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/PreviewRedeemWithTypeReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/PreviewRepayReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/PreviewRepaySharesReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/PreviewWithdrawReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/PreviewWithdrawWithTypeReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/RedeemReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/RedeemWithTypeReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/RepayReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/RepaySharesReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/SiloConfigReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/SiloTokenReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/SwitchCollateralToThisSiloReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/SymbolReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/SynchronizeHooksTokenReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/TotalAssetsReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/TotalSupplyReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/TransferFromReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/TransferReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/TransitionCollateralReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/UpdateHooksReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/UtilizationDataReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/WithdrawFeesReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/WithdrawReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo/WithdrawWithTypeReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-config/AccrueInterestForBothSilosReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-config/AccrueInterestForSiloReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-config/BorrowerCollateralSiloReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-config/GetAssetForSiloReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-config/GetCollateralShareTokenAndAssetReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-config/GetConfigReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-config/GetConfigsForBorrowReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-config/GetConfigsForWithdrawReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-config/GetConfigsReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-config/GetDebtShareTokenAndAssetReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-config/GetDebtSiloReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-config/GetFeesWithAssetReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-config/GetShareTokensReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-config/GetSilosReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-config/HasDebtInOtherSiloReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-config/OnDebtTransferReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-config/ReentrancyGuardEnteredReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-config/SetOtherSiloAsCollateralSiloReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-config/SetThisSiloAsCollateralSiloReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-config/SiloIDReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-config/TurnOffReentrancyProtectionReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-config/TurnOnReentrancyProtectionReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-hook-v1/AcceptOwnershipReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-hook-v1/AfterActionReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-hook-v1/BeforeActionReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-hook-v1/ConfiguredGaugesReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-hook-v1/HookReceiverConfigReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-hook-v1/InitializeReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-hook-v1/LiquidationCallReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-hook-v1/MaxLiquidationReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-hook-v1/OwnerReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-hook-v1/PendingOwnerReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-hook-v1/RemoveGaugeReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-hook-v1/RenounceOwnershipReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-hook-v1/SetGaugeReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-hook-v1/SiloConfigReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/methods/silo-hook-v1/TransferOwnershipReentrancyTest.sol |
| ./silo-core/test/foundry/Silo/reentrancy/registries/CollateralShareTokenMethodsRegistry.sol |
| ./silo-core/test/foundry/Silo/reentrancy/registries/DebtShareTokenMethodsRegistry.sol |
| ./silo-core/test/foundry/Silo/reentrancy/registries/Registries.sol |
| ./silo-core/test/foundry/Silo/reentrancy/registries/ShareTokenMethodsRegistry.sol |
| ./silo-core/test/foundry/Silo/reentrancy/registries/SiloConfigMethodsRegistry.sol |
| ./silo-core/test/foundry/Silo/reentrancy/registries/SiloHookV1MethodsRegistry.sol |
| ./silo-core/test/foundry/Silo/reentrancy/registries/SiloMethodsRegistry.sol |
| ./silo-core/test/foundry/Silo/repay/Repay.i.sol |
| ./silo-core/test/foundry/Silo/repay/RepayAllowance.i.sol |
| ./silo-core/test/foundry/Silo/transitionCollateral/SwitchCollateralTo.i.sol |
| ./silo-core/test/foundry/Silo/transitionCollateral/TransitionCollateral.i.sol |
| ./silo-core/test/foundry/Silo/transitionCollateral/TransitionCollateralReentrancy.i.sol |
| ./silo-core/test/foundry/Silo/updateHooks/UpdateHooks.i.sol |
| ./silo-core/test/foundry/Silo/withdraw/WithdrawAllowance.i.sol |
| ./silo-core/test/foundry/Silo/withdraw/WithdrawWhenDebt.i.sol |
| ./silo-core/test/foundry/Silo/withdraw/WithdrawWhenNoDebt.i.sol |
| ./silo-core/test/foundry/Silo/withdraw/WithdrawWhenNoDeposit.i.sol |
| ./silo-core/test/foundry/SiloConfig/OrderedConfigs.t.sol |
| ./silo-core/test/foundry/SiloConfig/SiloConfig.t.sol |
| ./silo-core/test/foundry/SiloFactory/SiloFactoryCreateSiloAddrValidationsTest.t.sol |
| ./silo-core/test/foundry/SiloFactory/SiloFactoryCreateSiloTest.t.sol |
| ./silo-core/test/foundry/SiloFactory/SiloFactorySettersTest.t.sol |
| ./silo-core/test/foundry/SiloFactory/SiloFactoryTest.t.sol |
| ./silo-core/test/foundry/SiloFactory/SiloFactoryValidateSiloInitDataTest.t.sol |
| ./silo-core/test/foundry/SiloLens/SiloLens.i.sol |
| ./silo-core/test/foundry/SiloLens/SiloLens.t.sol |
| ./silo-core/test/foundry/SiloRouter/SiloRouterActions.t.sol |
| ./silo-core/test/foundry/SiloVerifier/SiloVerifier.s.t.sol |
| ./silo-core/test/foundry/_audits/cantina/CantinaTicket.sol |
| ./silo-core/test/foundry/_audits/cantina/CantinaTicket148.sol |
| ./silo-core/test/foundry/_audits/cantina/CantinaTicket195.sol |
| ./silo-core/test/foundry/_audits/cantina/CantinaTicket235.sol |
| ./silo-core/test/foundry/_audits/cantina/CantinaTicket236.sol |
| ./silo-core/test/foundry/_audits/cantina/CantinaTicket239.sol |
| ./silo-core/test/foundry/_audits/cantina/CantinaTicket61.sol |
| ./silo-core/test/foundry/_common/Assertions.sol |
| ./silo-core/test/foundry/_common/DummyOracle.sol |
| ./silo-core/test/foundry/_common/InterestRateModelConfigs.sol |
| ./silo-core/test/foundry/_common/MintableToken.sol |
| ./silo-core/test/foundry/_common/OraclesHelper.sol |
| ./silo-core/test/foundry/_common/PartialLiquidationExecLibImpl.sol |
| ./silo-core/test/foundry/_common/ShareTokenDecimalsPowLib.sol |
| ./silo-core/test/foundry/_common/SiloLendingLibImpl.sol |
| ./silo-core/test/foundry/_common/SiloLittleHelper.sol |
| ./silo-core/test/foundry/_common/TransferOwnership.sol |
| ./silo-core/test/foundry/_common/fixtures/SiloFixture.sol |
| ./silo-core/test/foundry/_common/fixtures/SiloFixtureWithVeSilo.sol |
| ./silo-core/test/foundry/_mocks/ContractThatAcceptsETH.sol |
| ./silo-core/test/foundry/_mocks/DebtInfoLib.sol |
| ./silo-core/test/foundry/_mocks/ERC20UpgradableMock.sol |
| ./silo-core/test/foundry/_mocks/FlashLoanReceiverWithInvalidResponse.sol |
| ./silo-core/test/foundry/_mocks/HookReceiverAllActionsWithEvents.sol |
| ./silo-core/test/foundry/_mocks/HookReceiverMock.sol |
| ./silo-core/test/foundry/_mocks/InterestRateModelMock.sol |
| ./silo-core/test/foundry/_mocks/InterestRateModelV2ConfigHarness.sol |
| ./silo-core/test/foundry/_mocks/OracleMock.sol |
| ./silo-core/test/foundry/_mocks/SiloConfigMock.sol |
| ./silo-core/test/foundry/_mocks/SiloERC4626Lib/ISiloERC4626LibConsumerMock.sol |
| ./silo-core/test/foundry/_mocks/SiloERC4626Lib/SiloERC4626LibConsumerNonVulnerable.sol |
| ./silo-core/test/foundry/_mocks/SiloERC4626Lib/SiloERC4626LibConsumerVulnerable.sol |
| ./silo-core/test/foundry/_mocks/SiloERC4626Lib/SiloERC4626LibWithReentrancyIssue.sol |
| ./silo-core/test/foundry/_mocks/SiloERC4626Lib/TokenWithReentrancy.sol |
| ./silo-core/test/foundry/_mocks/SiloFactoryMock.sol |
| ./silo-core/test/foundry/_mocks/SiloHookReceiverHarness.sol |
| ./silo-core/test/foundry/_mocks/SiloLendingLib/ISiloLendingLibConsumerMock.sol |
| ./silo-core/test/foundry/_mocks/SiloLendingLib/SiloLendingLibConsumerNonVulnerable.sol |
| ./silo-core/test/foundry/_mocks/SiloLendingLib/SiloLendingLibConsumerVulnerable.sol |
| ./silo-core/test/foundry/_mocks/SiloLendingLib/SiloLendingLibWithReentrancyIssue.sol |
| ./silo-core/test/foundry/_mocks/SiloLendingLib/TokenWithReentrancy.sol |
| ./silo-core/test/foundry/_mocks/SiloMock.sol |
| ./silo-core/test/foundry/_mocks/SiloStorageExtension.sol |
| ./silo-core/test/foundry/_mocks/TokenMock.sol |
| ./silo-core/test/foundry/_mocks/oracles-factories/ChainlinkV3OracleFactoryMock.sol |
| ./silo-core/test/foundry/_mocks/oracles-factories/DIAOracleFactoryMock.sol |
| ./silo-core/test/foundry/_mocks/oracles-factories/UniswapV3OracleFactoryMock.sol |
| ./silo-core/test/foundry/_protocol/CommonSiloIntegration.sol |
| ./silo-core/test/foundry/_protocol/ERC4626Compliance.t.sol |
| ./silo-core/test/foundry/_protocol/Silo.integration.t.sol |
| ./silo-core/test/foundry/_protocol/SiloContracts.sol |
| ./silo-core/test/foundry/_protocol/SiloDecimals.t.sol |
| ./silo-core/test/foundry/_protocol/VeSiloFeatures.sol |
| ./silo-core/test/foundry/common/SiloCoreDeployments.i.sol |
| ./silo-core/test/foundry/data/PRBMathSD59x18_exp2_data.sol |
| ./silo-core/test/foundry/data/PRBMathSD59x18_exp_data.sol |
| ./silo-core/test/foundry/data-readers/CalculateCollateralToLiquidateTestData.sol |
| ./silo-core/test/foundry/data-readers/CalculateMaxAssetsToWithdrawTestData.sol |
| ./silo-core/test/foundry/data-readers/EstimateMaxRepayValueTestData.sol |
| ./silo-core/test/foundry/data-readers/GetAssetsDataForLtvCalculationsTestData.sol |
| ./silo-core/test/foundry/data-readers/GetExactLiquidationAmountsTestData.sol |
| ./silo-core/test/foundry/data-readers/LiquidationPreviewTestData.sol |
| ./silo-core/test/foundry/data-readers/MaxBorrowValueToAssetsAndSharesTestData.sol |
| ./silo-core/test/foundry/data-readers/MaxLiquidationPreviewTestData.sol |
| ./silo-core/test/foundry/data-readers/MaxWithdrawToAssetsAndSharesTestData.sol |
| ./silo-core/test/foundry/data-readers/RcompTestData.sol |
| ./silo-core/test/foundry/data-readers/RcurTestData.sol |
| ./silo-core/test/foundry/data-readers/SiloLendingLibBorrowTestData.sol |
| ./silo-core/test/foundry/debug/Incentives2025_01_18.sol |
| ./silo-core/test/foundry/debug/LiquidationDebug_2024_12_20.t.sol |
| ./silo-core/test/foundry/debug/SiloDebug.t.sol |
| ./silo-core/test/foundry/deploy/SiloHookV1Deploy.t.sol |
| ./silo-core/test/foundry/echidna-findings/EchidnaLiquidationCall.i.sol |
| ./silo-core/test/foundry/echidna-findings/EchidnaMaxWithdraw.i.sol |
| ./silo-core/test/foundry/echidna-findings/EchidnaMiddleman.sol |
| ./silo-core/test/foundry/echidna-findings/EchidnaSetup.sol |
| ./silo-core/test/foundry/gas/AccrueInterest.gas.sol |
| ./silo-core/test/foundry/gas/Borrow1st.gas.sol |
| ./silo-core/test/foundry/gas/Borrow2nd.gas.sol |
| ./silo-core/test/foundry/gas/BorrowAccrueInterest.gas.sol |
| ./silo-core/test/foundry/gas/CalculateCurrentInterestRate.gas.sol |
| ./silo-core/test/foundry/gas/Deposit1st.gas.sol |
| ./silo-core/test/foundry/gas/Deposit2nd.gas.sol |
| ./silo-core/test/foundry/gas/DepositAccrueInterest.gas.sol |
| ./silo-core/test/foundry/gas/EnumCastTest.gas.sol |
| ./silo-core/test/foundry/gas/Gas.sol |
| ./silo-core/test/foundry/gas/LiquidationAccrueInterest.gas.sol |
| ./silo-core/test/foundry/gas/RepayPart.gas.sol |
| ./silo-core/test/foundry/gas/RepayPartAccrueInterest.gas.sol |
| ./silo-core/test/foundry/gas/RepaySharesFullAccrueInterest.gas.sol |
| ./silo-core/test/foundry/gas/TransferCollateral.gas.sol |
| ./silo-core/test/foundry/gas/TransitionCollateral.gas.sol |
| ./silo-core/test/foundry/gas/WitdhrawPartAccrueInterest.gas.sol |
| ./silo-core/test/foundry/incentives/SiloIncentivesController.i.sol |
| ./silo-core/test/foundry/incentives/SiloIncentivesController.t.sol |
| ./silo-core/test/foundry/incentives/SiloIncentivesControllerGaugeLike.t.sol |
| ./silo-core/test/foundry/interestRateModel/InterestRateModelV2.t.sol |
| ./silo-core/test/foundry/interestRateModel/InterestRateModelV2Checked.sol |
| ./silo-core/test/foundry/interestRateModel/InterestRateModelV2Config.t.sol |
| ./silo-core/test/foundry/interestRateModel/InterestRateModelV2ConfigFactory.t.sol |
| ./silo-core/test/foundry/interestRateModel/InterestRateModelV2Impl.sol |
| ./silo-core/test/foundry/interestRateModel/InterestRateModelV2Rcomp.t.sol |
| ./silo-core/test/foundry/interestRateModel/InterestRateModelV2Rcur.t.sol |
| ./silo-core/test/foundry/lib/Actions/ActionsInitialize.t.sol |
| ./silo-core/test/foundry/lib/FuncAsParam.t.sol |
| ./silo-core/test/foundry/lib/Hook.t.sol |
| ./silo-core/test/foundry/lib/PRBMathSD59x18.t.sol |
| ./silo-core/test/foundry/lib/ReverBytestLib.t.sol |
| ./silo-core/test/foundry/lib/SiloERC4626Lib/ReentrancyOnDeposit.t.sol |
| ./silo-core/test/foundry/lib/SiloLendingLib/AccrueInterestForAsset.t.sol |
| ./silo-core/test/foundry/lib/SiloLendingLib/Borrow.t.sol |
| ./silo-core/test/foundry/lib/SiloLendingLib/MaxBorrowValueToAssetsAndShares.t.sol |
| ./silo-core/test/foundry/lib/SiloLendingLib/ReentrancyOnRepay.t.sol |
| ./silo-core/test/foundry/lib/SiloMathLib/CalculateMaxAssetsToWithdraw.t.sol |
| ./silo-core/test/foundry/lib/SiloMathLib/CalculateMaxBorrowValue.t.sol |
| ./silo-core/test/foundry/lib/SiloMathLib/CalculateUtilization.t.sol |
| ./silo-core/test/foundry/lib/SiloMathLib/Conversions.t.sol |
| ./silo-core/test/foundry/lib/SiloMathLib/ConvertToAssets.t.sol |
| ./silo-core/test/foundry/lib/SiloMathLib/ConvertToAssetsAndToShares.t.sol |
| ./silo-core/test/foundry/lib/SiloMathLib/ConvertToShares.t.sol |
| ./silo-core/test/foundry/lib/SiloMathLib/GetCollateralAmountsWithInterest.t.sol |
| ./silo-core/test/foundry/lib/SiloMathLib/GetDebtAmountsWithInterest.t.sol |
| ./silo-core/test/foundry/lib/SiloMathLib/Liquidity.t.sol |
| ./silo-core/test/foundry/lib/SiloMathLib/MaxWithdrawToAssetsAndShares.t.sol |
| ./silo-core/test/foundry/lib/SiloMathLib/MulDivOverflow.t.sol |
| ./silo-core/test/foundry/lib/SiloSolvencyLib/CalculateLtvTest.t.sol |
| ./silo-core/test/foundry/lib/SiloSolvencyLib/GetAssetsDataForLtvCalculations.t.sol |
| ./silo-core/test/foundry/lib/SiloSolvencyLib/GetPositionValues.t.sol |
| ./silo-core/test/foundry/lib/SiloSolvencyLib/IsBelowMaxLtv.t.sol |
| ./silo-core/test/foundry/lib/SiloSolvencyLib/LtvMath.t.sol |
| ./silo-core/test/foundry/lib/SiloStdLib/FlashFee.t.sol |
| ./silo-core/test/foundry/lib/SiloStdLib/GetFeesAndFeeReceiversWithAsset.t.sol |
| ./silo-core/test/foundry/lib/SiloStdLib/GetSharesAndTotalSupply.t.sol |
| ./silo-core/test/foundry/lib/SiloStdLib/GetTotalAssetsAndTotalSharesWithInterest.t.sol |
| ./silo-core/test/foundry/lib/SiloStdLib/GetTotalCollateralAssetsWithInterest.t.sol |
| ./silo-core/test/foundry/lib/SiloStdLib/GetTotalDebtAssetsWithInterest.t.sol |
| ./silo-core/test/foundry/lib/SiloStdLib/WithdrawFees.t.sol |
| ./silo-core/test/foundry/lib/TokenHelper.t.sol |
| ./silo-core/test/foundry/lib/Views/UtilizationData.t.sol |
| ./silo-core/test/foundry/simulations/BorrowImmediateBadDebt.i.sol |
| ./silo-core/test/foundry/simulations/DustPropagation.i.sol |
| ./silo-core/test/foundry/simulations/DustPropagationLoop.i.sol |
| ./silo-core/test/foundry/simulations/EggsSonicPriceProvider.sol |
| ./silo-core/test/foundry/simulations/InterestOverflow.i.sol |
| ./silo-core/test/foundry/simulations/inflation-attack/CollateralTokenInflationAttack.i.sol |
| ./silo-core/test/foundry/simulations/inflation-attack/ShareManipulation.i.sol |
| ./silo-core/test/foundry/storage/StorageUpdateTest.t.sol |
| ./silo-core/test/foundry/utils/CrossReentrancyGuard.t.sol |
| ./silo-core/test/foundry/utils/EncodeDecodePackedTest.sol |
| ./silo-core/test/foundry/utils/ShareCollateralToken.t.sol |
| ./silo-core/test/foundry/utils/ShareDebtToken.t.sol |
| ./silo-core/test/foundry/utils/ShareDebtTokenNotInitialized.t.sol |
| ./silo-core/test/foundry/utils/ShareToken.t.sol |
| ./silo-core/test/foundry/utils/ShareTokenCommonTest.sol |
| ./silo-core/test/foundry/utils/hook-receivers/HookCallsOutsideAction.t.sol |
| ./silo-core/test/foundry/utils/hook-receivers/SiloHookReceiver.t.sol |
| ./silo-core/test/foundry/utils/hook-receivers/gauge/GaugeHookReceiver.t.sol |
| ./silo-core/test/foundry/utils/hook-receivers/liquidation/LiquidationCall_1token.i.sol |
| ./silo-core/test/foundry/utils/hook-receivers/liquidation/LiquidationCall_2tokens.i.sol |
| ./silo-core/test/foundry/utils/hook-receivers/liquidation/lib/PartialLiquidationExecLib/GetExactLiquidationAmounts.t.sol |
| ./silo-core/test/foundry/utils/hook-receivers/liquidation/lib/PartialLiquidationExecLib/LiquidationPreviewTest.t.sol |
| ./silo-core/test/foundry/utils/hook-receivers/liquidation/lib/PartialLiquidationLib/MaxLiquidation.t.sol |
| ./silo-core/test/foundry/utils/hook-receivers/liquidation/lib/PartialLiquidationLib/MaxRepayRawMath.sol |
| ./silo-core/test/foundry/utils/hook-receivers/liquidation/lib/PartialLiquidationLib/PartialLiquidationLib.t.sol |
| ./silo-core/test/foundry/utils/hook-receivers/liquidation/lib/PartialLiquidationLib/PartialLiquidationLibChecked.sol |
| ./silo-core/test/foundry/utils/liquidationHelper/DexSwapOdosSonicTest.i.sol |
| ./silo-core/test/foundry/utils/liquidationHelper/LiquidationHelperCommon.sol |
| ./silo-core/test/foundry/utils/liquidationHelper/LiquidationHelperOdos.i.sol |
| ./silo-core/test/foundry/utils/liquidationHelper/LiquidationHelper_1token.i.sol |
| ./silo-core/test/foundry/utils/liquidationHelper/LiquidationHelper_2tokens.i.sol |
| ./silo-core/test/foundry/utils/liquidationHelper/LiquidationWrongInputs.i.sol |
| ./silo-core/test/foundry/utils/liquidationHelper/ManualLiquidationHelperCommon.sol |
| ./silo-core/test/foundry/utils/liquidationHelper/ManualLiquidationHelper_1token.i.sol |
| ./silo-core/test/foundry/utils/liquidationHelper/ManualLiquidationHelper_2tokens.i.sol |
| ./silo-core/test/foundry/utils/liquidationHelper/ManualLiquidationHelper_2tokens_receiver.i.sol |
| ./silo-core/test/foundry/utils/liquidationHelper/ManualLiquidationHelper_2tokens_sTokens.i.sol |
| ./silo-core/test/foundry/utils/liquidationHelper/debug/LiquidationHelperDebug20250124.sol |
| ./silo-core/test/foundry/utils/liquidationHelper/debug/LiquidationHelperDebug20250127.sol |
| ./silo-core/test/foundry/utils/liquidationHelper/debug/LiquidationHelperDebug20250128_0xa2532e7.sol |
| ./silo-core/test/foundry/utils/liquidationHelper/debug/LiquidationHelperDebug20250128_0xaa489b.sol |
| ./silo-core/test/foundry/utils/liquidationHelper/debug/LiquidationHelperDebug20250128_0xbbd006.sol |
| ./silo-core/test/foundry/utils/liquidationHelper/debug/LiquidationHelperDebug20250129_0x9b6097.sol |
| ./silo-core/test/foundry/utils/liquidationHelper/debug/LiquidationHelperDebug20250129_0xbc7405.sol |
| ./silo-core/test/foundry/utils/liquidationHelper/debug/LiquidationHelperDebug20250212_0xbc7405.sol |
| ./silo-core/test/invariants/CryticToFoundry.t.sol |
| ./silo-core/test/invariants/HandlerAggregator.t.sol |
| ./silo-core/test/invariants/Invariants.t.sol |
| ./silo-core/test/invariants/Setup.t.sol |
| ./silo-core/test/invariants/SpecAggregator.t.sol |
| ./silo-core/test/invariants/Tester.t.sol |
| ./silo-core/test/invariants/base/BaseHandler.t.sol |
| ./silo-core/test/invariants/base/BaseHooks.t.sol |
| ./silo-core/test/invariants/base/BaseStorage.t.sol |
| ./silo-core/test/invariants/base/BaseTest.t.sol |
| ./silo-core/test/invariants/base/ProtocolAssertions.t.sol |
| ./silo-core/test/invariants/handlers/interfaces/IBorrowingHandler.sol |
| ./silo-core/test/invariants/handlers/interfaces/ILiquidationHandler.sol |
| ./silo-core/test/invariants/handlers/interfaces/ISiloHandler.sol |
| ./silo-core/test/invariants/handlers/interfaces/IVaultHandler.sol |
| ./silo-core/test/invariants/handlers/permissioned/SiloConfigHandler.t.sol |
| ./silo-core/test/invariants/handlers/permissioned/SiloFactoryHandler.t.sol |
| ./silo-core/test/invariants/handlers/simulators/FlashLoanHandler.t.sol |
| ./silo-core/test/invariants/handlers/simulators/MockOracleHandler.t.sol |
| ./silo-core/test/invariants/handlers/user/BorrowingHandler.t.sol |
| ./silo-core/test/invariants/handlers/user/LiquidationHandler.t.sol |
| ./silo-core/test/invariants/handlers/user/ShareTokenHandler.t.sol |
| ./silo-core/test/invariants/handlers/user/SiloHandler.t.sol |
| ./silo-core/test/invariants/handlers/user/VaultHandler.t.sol |
| ./silo-core/test/invariants/helpers/FlashLoanReceiver.sol |
| ./silo-core/test/invariants/hooks/DefaultBeforeAfterHooks.t.sol |
| ./silo-core/test/invariants/hooks/HookAggregator.t.sol |
| ./silo-core/test/invariants/invariants/BaseInvariants.t.sol |
| ./silo-core/test/invariants/invariants/LendingBorrowingInvariants.t.sol |
| ./silo-core/test/invariants/invariants/SiloMarketInvariants.t.sol |
| ./silo-core/test/invariants/specs/InvariantsSpec.t.sol |
| ./silo-core/test/invariants/specs/PostconditionsSpec.t.sol |
| ./silo-core/test/invariants/utils/Actor.sol |
| ./silo-core/test/invariants/utils/DeployPermit2.sol |
| ./silo-core/test/invariants/utils/Pretty.sol |
| ./silo-core/test/invariants/utils/PropertiesAsserts.sol |
| ./silo-core/test/invariants/utils/PropertiesConstants.sol |
| ./silo-core/test/invariants/utils/StdAsserts.sol |
| ./silo-core/test/invariants/utils/mocks/MockSiloOracle.sol |
| ./silo-core/test/invariants/utils/mocks/TestERC20.sol |
| ./silo-oracles/constants/Arbitrum.sol |
| ./silo-oracles/constants/Ethereum.sol |
| ./silo-oracles/contracts/_common/Layer1OracleConfig.sol |
| ./silo-oracles/contracts/_common/OracleFactory.sol |
| ./silo-oracles/contracts/chainlinkV3/ChainlinkV3Oracle.sol |
| ./silo-oracles/contracts/chainlinkV3/ChainlinkV3OracleConfig.sol |
| ./silo-oracles/contracts/chainlinkV3/ChainlinkV3OracleFactory.sol |
| ./silo-oracles/contracts/custom/EggsToSonicAdapter.sol |
| ./silo-oracles/contracts/custom/WusdPlusUsdAdapter.sol |
| ./silo-oracles/contracts/dia/DIAOracle.sol |
| ./silo-oracles/contracts/dia/DIAOracleConfig.sol |
| ./silo-oracles/contracts/dia/DIAOracleFactory.sol |
| ./silo-oracles/contracts/erc4626/ERC4626Oracle.sol |
| ./silo-oracles/contracts/erc4626/ERC4626OracleFactory.sol |
| ./silo-oracles/contracts/external/dia/IDIAOracleV2.sol |
| ./silo-oracles/contracts/forwarder/OracleForwarder.sol |
| ./silo-oracles/contracts/forwarder/OracleForwarderFactory.sol |
| ./silo-oracles/contracts/interfaces/IChainlinkV3Factory.sol |
| ./silo-oracles/contracts/interfaces/IChainlinkV3Oracle.sol |
| ./silo-oracles/contracts/interfaces/IDIAOracle.sol |
| ./silo-oracles/contracts/interfaces/IDIAOracleFactory.sol |
| ./silo-oracles/contracts/interfaces/IERC20BalanceOf.sol |
| ./silo-oracles/contracts/interfaces/IERC4626OracleFactory.sol |
| ./silo-oracles/contracts/interfaces/IOracleForwarder.sol |
| ./silo-oracles/contracts/interfaces/IOracleForwarderFactory.sol |
| ./silo-oracles/contracts/interfaces/IOracleScalerFactory.sol |
| ./silo-oracles/contracts/interfaces/IPendlePTOracleFactory.sol |
| ./silo-oracles/contracts/interfaces/IPythAggregatorFactory.sol |
| ./silo-oracles/contracts/interfaces/IUniswapV3Factory.sol |
| ./silo-oracles/contracts/interfaces/IUniswapV3Oracle.sol |
| ./silo-oracles/contracts/lib/Clones.sol |
| ./silo-oracles/contracts/lib/OracleNormalization.sol |
| ./silo-oracles/contracts/lib/RevertBytes.sol |
| ./silo-oracles/contracts/oracleForQA/OracleForQA.sol |
| ./silo-oracles/contracts/pendle/PendlePTOracle.sol |
| ./silo-oracles/contracts/pendle/PendlePTOracleFactory.sol |
| ./silo-oracles/contracts/pendle/interfaces/IPendleMarketV3Like.sol |
| ./silo-oracles/contracts/pendle/interfaces/IPendleSYTokenLike.sol |
| ./silo-oracles/contracts/pendle/interfaces/IPyYtLpOracleLike.sol |
| ./silo-oracles/contracts/pyth/PythAggregatorFactory.sol |
| ./silo-oracles/contracts/scaler/OracleScaler.sol |
| ./silo-oracles/contracts/scaler/OracleScalerFactory.sol |
| ./silo-oracles/contracts/silo-virtual-assets/SiloVirtualAsset18Decimals.sol |
| ./silo-oracles/contracts/silo-virtual-assets/SiloVirtualAsset8Decimals.sol |
| ./silo-oracles/contracts/uniswapV3/UniswapV3Oracle.sol |
| ./silo-oracles/contracts/uniswapV3/UniswapV3OracleConfig.sol |
| ./silo-oracles/contracts/uniswapV3/UniswapV3OracleFactory.sol |
| ./silo-oracles/deploy/CommonDeploy.sol |
| ./silo-oracles/deploy/EggsToSonicAdapterDeploy.sol |
| ./silo-oracles/deploy/OracleForwarderFactoryDeploy.sol |
| ./silo-oracles/deploy/OraclesDeployments.sol |
| ./silo-oracles/deploy/SiloOraclesContracts.sol |
| ./silo-oracles/deploy/SiloOraclesFactoriesContracts.sol |
| ./silo-oracles/deploy/SiloVirtualAsset8DecimalsDeploy.s.sol |
| ./silo-oracles/deploy/WusdPlusUsdAdapterDeploy.sol |
| ./silo-oracles/deploy/chainlink-v3-oracle/ChainlinkV3OracleDeploy.s.sol |
| ./silo-oracles/deploy/chainlink-v3-oracle/ChainlinkV3OracleFactoryDeploy.s.sol |
| ./silo-oracles/deploy/chainlink-v3-oracle/ChainlinkV3OraclesConfigsParser.sol |
| ./silo-oracles/deploy/dia-oracle/DIAOracleDeploy.s.sol |
| ./silo-oracles/deploy/dia-oracle/DIAOracleFactoryDeploy.s.sol |
| ./silo-oracles/deploy/dia-oracle/DIAOraclesConfigsParser.sol |
| ./silo-oracles/deploy/erc4626/ERC4626OracleDeploy.s.sol |
| ./silo-oracles/deploy/erc4626/ERC4626OracleFactoryDeploy.sol |
| ./silo-oracles/deploy/oracle-scaler/OracleScalerDeploy.s.sol |
| ./silo-oracles/deploy/oracle-scaler/OracleScalerFactoryDeploy.s.sol |
| ./silo-oracles/deploy/oracleForQA/OracleForQADeploy.s.sol |
| ./silo-oracles/deploy/pendle/PendlePTOracleDeploy.s.sol |
| ./silo-oracles/deploy/pendle/PendlePTOracleFactoryDeploy.s.sol |
| ./silo-oracles/deploy/pyth/PythAggregatorFactoryDeploy.s.sol |
| ./silo-oracles/deploy/uniswap-v3-oracle/UniswapV3OracleDeploy.s.sol |
| ./silo-oracles/deploy/uniswap-v3-oracle/UniswapV3OracleFactoryDeploy.s.sol |
| ./silo-oracles/deploy/uniswap-v3-oracle/UniswapV3OraclesConfigsParser.sol |
| ./silo-oracles/test/foundry/_common/ChainlinkV3Configs.sol |
| ./silo-oracles/test/foundry/_common/DIAConfigDefault.sol |
| ./silo-oracles/test/foundry/_common/Forking.sol |
| ./silo-oracles/test/foundry/_common/MockAggregatorV3.sol |
| ./silo-oracles/test/foundry/_common/OracleFactory.t.sol |
| ./silo-oracles/test/foundry/_common/TokensGenerator.sol |
| ./silo-oracles/test/foundry/_common/UniswapPools.sol |
| ./silo-oracles/test/foundry/_common/Whales.sol |
| ./silo-oracles/test/foundry/_mocks/silo-oracles/SiloOracleMock1.sol |
| ./silo-oracles/test/foundry/_mocks/silo-oracles/SiloOracleMock2.sol |
| ./silo-oracles/test/foundry/chainlinkV3/ChainlinkV3OracleFactory.t.sol |
| ./silo-oracles/test/foundry/custom/EggsToSonicAdapter.t.sol |
| ./silo-oracles/test/foundry/custom/WusdPlusUsdAdapter.integration.t.sol |
| ./silo-oracles/test/foundry/dia/DIAOracle.t.sol |
| ./silo-oracles/test/foundry/dia/DIAOracleConfig.t.sol |
| ./silo-oracles/test/foundry/dia/DIAOracleFactory.t.sol |
| ./silo-oracles/test/foundry/erc4626/ERC4626Oracle.t.sol |
| ./silo-oracles/test/foundry/forwarder/OracleForwarder.t.sol |
| ./silo-oracles/test/foundry/interfaces/IERC20.sol |
| ./silo-oracles/test/foundry/interfaces/IERC20Metadata.sol |
| ./silo-oracles/test/foundry/interfaces/IForking.sol |
| ./silo-oracles/test/foundry/pendle/PendlePTOracle.t.sol |
| ./silo-oracles/test/foundry/pyth/PythAggregatorFactory.t.sol |
| ./silo-oracles/test/foundry/scaler/OracleScaler.t.sol |
| ./silo-oracles/test/foundry/uniswapV3/UniswapV3Oracle.t.sol |
| ./silo-oracles/test/foundry/uniswapV3/UniswapV3OracleConfig.integration.t.sol |
| ./silo-oracles/test/foundry/uniswapV3/UniswapV3OracleFactory.t.sol |
| ./silo-vaults/common/SiloVaultsContracts.sol |
| ./silo-vaults/contracts/mocks/ERC1820Registry.sol |
| ./silo-vaults/contracts/mocks/ERC777Mock.sol |
| ./silo-vaults/deploy/IdleVaultsFactoryDeploy.s.sol |
| ./silo-vaults/deploy/PublicAllocatorDeploy.s.sol |
| ./silo-vaults/deploy/SiloIncentivesControllerCLFactoryDeploy.s.sol |
| ./silo-vaults/deploy/SiloVaultsFactoryDeploy.s.sol |
| ./silo-vaults/deploy/common/CommonDeploy.sol |
| ./silo-vaults/test/foundry/DeploymentTest.sol |
| ./silo-vaults/test/foundry/ERC4626ComplianceTest.sol |
| ./silo-vaults/test/foundry/ERC4626Test.sol |
| ./silo-vaults/test/foundry/FeeTest.sol |
| ./silo-vaults/test/foundry/GuardianTest.sol |
| ./silo-vaults/test/foundry/IdleVaultTest.sol |
| ./silo-vaults/test/foundry/MarketTest.sol |
| ./silo-vaults/test/foundry/MulticallTest.sol |
| ./silo-vaults/test/foundry/PermitTest.sol |
| ./silo-vaults/test/foundry/PublicAllocatorTest.sol |
| ./silo-vaults/test/foundry/ReallocateIdleTest.sol |
| ./silo-vaults/test/foundry/ReallocateWithdrawTest.sol |
| ./silo-vaults/test/foundry/ReentrancyTest.sol |
| ./silo-vaults/test/foundry/RevokeTest.sol |
| ./silo-vaults/test/foundry/RoleTest.sol |
| ./silo-vaults/test/foundry/SiloVaultInternalTest.sol |
| ./silo-vaults/test/foundry/SiloVaultsFactoryTest.sol |
| ./silo-vaults/test/foundry/TimelockTest.sol |
| ./silo-vaults/test/foundry/TryCatchForOOGTest.t.sol |
| ./silo-vaults/test/foundry/VaultIncentivesModuleTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/MaliciousToken.sol |
| ./silo-vaults/test/foundry/call-and-reenter/TestState.sol |
| ./silo-vaults/test/foundry/call-and-reenter/VaultReentrancy.t.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/AcceptCapTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/AcceptGuardianTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/AcceptOwnershipTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/AcceptTimelockTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/AllowanceTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/ApproveTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/AssetTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/BalanceOfTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/BalanceTrackerTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/ClaimRewardsTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/ConfigTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/ConvertToAssetsTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/ConvertToSharesTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/CuratorTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/DecimalsOffsetTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/DecimalsReentrancyTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/DepositReentrancyTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/DomainSeparatorTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/EIP712Domain.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/FeeRecipientTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/FeeTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/GuardianTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/IncentivesModuleTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/IsAllocatorTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/LastTotalAssetsTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/MaxDepositTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/MaxMintTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/MaxRedeemTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/MaxWithdrawTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/MintTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/MulticallTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/NameTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/NoncesTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/OwnerTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/PendingCapTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/PendingGuardianTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/PendingOwnerTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/PendingTimelockTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/PermitReentrancyTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/PreviewDepositTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/PreviewMintTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/PreviewRedeemTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/PreviewWithdrawTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/ReallocateTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/RedeemReentrancyTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/ReentrancyGuardEnteredTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/RenounceOwnershipTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/RevokePendingCapTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/RevokePendingGuardianTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/RevokePendingMarketRemovalTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/RevokePendingTimelockTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/SetCuratorReentrancyTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/SetFeeRecipientTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/SetFeeTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/SetIsAllocatorTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/SetSupplyQueueTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/SubmitCapTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/SubmitGuardianTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/SubmitMarketRemovalTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/SubmitTimelockTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/SupplyQueueLengthTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/SupplyQueueTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/SymbolTest copy.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/SymbolTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/TimelockTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/TotalAssetsTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/TotalSupplyTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/TransferFromTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/TransferOwnershipTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/TransferTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/UpdateWithdrawQueueTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/WithdrawQueueLengthTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/WithdrawQueueTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/methods/WithdrawReentrancyTest.sol |
| ./silo-vaults/test/foundry/call-and-reenter/registries/Registries.sol |
| ./silo-vaults/test/foundry/call-and-reenter/registries/SiloVaultMethodsRegistry.sol |
| ./silo-vaults/test/foundry/fromCore/_common/VaultsLittleHelper.sol |
| ./silo-vaults/test/foundry/fromCore/deposit/Deposit.i.sol |
| ./silo-vaults/test/foundry/fromCore/deposit/Mint.i.sol |
| ./silo-vaults/test/foundry/fromCore/max/maxDeposit/MaxDeposit.i.sol |
| ./silo-vaults/test/foundry/fromCore/max/maxDeposit/MaxMint.i.sol |
| ./silo-vaults/test/foundry/fromCore/max/maxWithdraw/MaxRedeem.i.sol |
| ./silo-vaults/test/foundry/fromCore/max/maxWithdraw/MaxWithdraw.i.sol |
| ./silo-vaults/test/foundry/fromCore/preview/previewDeposit/PreviewDeposit.i.sol |
| ./silo-vaults/test/foundry/fromCore/preview/previewDeposit/PreviewMint.i.sol |
| ./silo-vaults/test/foundry/fromCore/preview/previewWithdraw/PreviewRedeem.i.sol |
| ./silo-vaults/test/foundry/fromCore/preview/previewWithdraw/PreviewWithdraw.i.sol |
| ./silo-vaults/test/foundry/helpers/BaseTest.sol |
| ./silo-vaults/test/foundry/helpers/IntegrationTest.sol |
| ./silo-vaults/test/foundry/helpers/InternalTest.sol |
| ./silo-vaults/test/foundry/helpers/SigUtils.sol |
| ./silo-vaults/test/foundry/incentives/VaultMultipleRewards.i.sol |
| ./silo-vaults/test/foundry/incentives/VaultRewardsIntegration.i.sol |
| ./silo-vaults/test/foundry/incentives/VaultRewardsIntegrationCap.i.sol |
| ./silo-vaults/test/foundry/incentives/VaultRewardsIntegrationSetup.sol |
| ./silo-vaults/test/foundry/incentives/VaultsSiloIncentives.i.sol |
| ./silo-vaults/test/foundry/incentives/VaultsSiloIncentivesReverts.i.sol |
| ./silo-vaults/test/foundry/incentives/claiming-logics/SiloIncentivesControllerCL.t.sol |
| ./silo-vaults/test/foundry/mocks/IncentivesClaimingLogicWithRevert.sol |
| ./silo-vaults/test/foundry/mocks/IncentivesControllerWithRevert.sol |
| ./ve-silo/common/VeSiloContracts.sol |
| ./ve-silo/contracts/access/ExtendedOwnable.sol |
| ./ve-silo/contracts/access/IExtendedOwnable.sol |
| ./ve-silo/contracts/access/Manageable.sol |
| ./ve-silo/contracts/fees-distribution/FeeDistributor.sol |
| ./ve-silo/contracts/fees-distribution/fee-swapper/FeeSwapper.sol |
| ./ve-silo/contracts/fees-distribution/fee-swapper/FeeSwapperConfig.sol |
| ./ve-silo/contracts/fees-distribution/fee-swapper/swappers/UniswapSwapper.sol |
| ./ve-silo/contracts/fees-distribution/fee-swapper/swappers/interfaces/IUniswapSwapRouterLike.sol |
| ./ve-silo/contracts/fees-distribution/interfaces/IBalancerVaultLike.sol |
| ./ve-silo/contracts/fees-distribution/interfaces/IFeeDistributor.sol |
| ./ve-silo/contracts/fees-distribution/interfaces/IFeeSwap.sol |
| ./ve-silo/contracts/fees-distribution/interfaces/IFeeSwapper.sol |
| ./ve-silo/contracts/gauges/BaseGaugeFactory.sol |
| ./ve-silo/contracts/gauges/_common/Version.sol |
| ./ve-silo/contracts/gauges/ccip/CCIPGauge.sol |
| ./ve-silo/contracts/gauges/ccip/CCIPGaugeFactory.sol |
| ./ve-silo/contracts/gauges/ccip/arbitrum/CCIPGaugeArbitrum.sol |
| ./ve-silo/contracts/gauges/ccip/arbitrum/CCIPGaugeArbitrumUpgradeableBeacon.sol |
| ./ve-silo/contracts/gauges/ccip/arbitrum/CCIPGaugeFactoryArbitrum.sol |
| ./ve-silo/contracts/gauges/ethereum/LiquidityGaugeFactory.sol |
| ./ve-silo/contracts/gauges/gauge-adder/GaugeAdder.sol |
| ./ve-silo/contracts/gauges/interfaces/IBatchGaugeCheckpointer.sol |
| ./ve-silo/contracts/gauges/interfaces/ICCIPExtraArgsConfig.sol |
| ./ve-silo/contracts/gauges/interfaces/ICCIPGauge.sol |
| ./ve-silo/contracts/gauges/interfaces/ICCIPGaugeCheckpointer.sol |
| ./ve-silo/contracts/gauges/interfaces/IChildChainGaugeFactory.sol |
| ./ve-silo/contracts/gauges/interfaces/IChildChainGaugeRegistry.sol |
| ./ve-silo/contracts/gauges/interfaces/IGaugeAdder.sol |
| ./ve-silo/contracts/gauges/interfaces/IGaugeController.sol |
| ./ve-silo/contracts/gauges/interfaces/IL2BalancerPseudoMinter.sol |
| ./ve-silo/contracts/gauges/interfaces/ILiquidityGaugeFactory.sol |
| ./ve-silo/contracts/gauges/interfaces/IShareTokenLike.sol |
| ./ve-silo/contracts/gauges/interfaces/ISiloChildChainGauge.sol |
| ./ve-silo/contracts/gauges/interfaces/ISiloLiquidityGauge.sol |
| ./ve-silo/contracts/gauges/interfaces/IStakelessGauge.sol |
| ./ve-silo/contracts/gauges/interfaces/IStakelessGaugeCheckpointer.sol |
| ./ve-silo/contracts/gauges/interfaces/IStakelessGaugeCheckpointerAdaptor.sol |
| ./ve-silo/contracts/gauges/l2-common/BatchGaugeCheckpointer.sol |
| ./ve-silo/contracts/gauges/l2-common/ChildChainGaugeFactory.sol |
| ./ve-silo/contracts/gauges/stakeless-gauge/CCIPGaugeCheckpointer.sol |
| ./ve-silo/contracts/gauges/stakeless-gauge/StakelessGauge.sol |
| ./ve-silo/contracts/gauges/stakeless-gauge/StakelessGaugeCheckpointerAdaptor.sol |
| ./ve-silo/contracts/governance/SiloGovernor.sol |
| ./ve-silo/contracts/governance/interfaces/ISiloGovernor.sol |
| ./ve-silo/contracts/governance/interfaces/ISiloTimelockController.sol |
| ./ve-silo/contracts/governance/interfaces/ISiloToken.sol |
| ./ve-silo/contracts/governance/interfaces/ISiloTokenChildChain.sol |
| ./ve-silo/contracts/governance/milo-token/MiloToken.sol |
| ./ve-silo/contracts/governance/milo-token/MiloTokenChildChain.sol |
| ./ve-silo/contracts/silo-tokens-minter/BalancerMinter.sol |
| ./ve-silo/contracts/silo-tokens-minter/BalancerTokenAdmin.sol |
| ./ve-silo/contracts/silo-tokens-minter/FeesManager.sol |
| ./ve-silo/contracts/silo-tokens-minter/L2BalancerPseudoMinter.sol |
| ./ve-silo/contracts/silo-tokens-minter/MainnetBalancerMinter.sol |
| ./ve-silo/contracts/silo-tokens-minter/helpers/EOASignaturesValidator.sol |
| ./ve-silo/contracts/silo-tokens-minter/interfaces/IBalancerMinter.sol |
| ./ve-silo/contracts/silo-tokens-minter/interfaces/IBalancerToken.sol |
| ./ve-silo/contracts/silo-tokens-minter/interfaces/IBalancerTokenAdmin.sol |
| ./ve-silo/contracts/silo-tokens-minter/interfaces/IFeesManager.sol |
| ./ve-silo/contracts/silo-tokens-minter/interfaces/IL2BalancerPseudoMinter.sol |
| ./ve-silo/contracts/silo-tokens-minter/interfaces/ILMGetters.sol |
| ./ve-silo/contracts/silo-tokens-minter/interfaces/IMainnetBalancerMinter.sol |
| ./ve-silo/contracts/silo-tokens-minter/interfaces/ISiloFactoryWithFeeDetails.sol |
| ./ve-silo/contracts/utils/CCIPMessageSender.sol |
| ./ve-silo/contracts/utils/EOASignaturesValidator.sol |
| ./ve-silo/contracts/utils/InputHelpers.sol |
| ./ve-silo/contracts/utils/OptionalOnlyCaller.sol |
| ./ve-silo/contracts/utils/SafeMath.sol |
| ./ve-silo/contracts/utils/SignaturesValidator.sol |
| ./ve-silo/contracts/voting-escrow/NullVotingEscrow.sol |
| ./ve-silo/contracts/voting-escrow/SmartWalletChecker.sol |
| ./ve-silo/contracts/voting-escrow/VeSiloDelegatorViaCCIP.sol |
| ./ve-silo/contracts/voting-escrow/VotingEscrowChildChain.sol |
| ./ve-silo/contracts/voting-escrow/VotingEscrowDelegationProxy.sol |
| ./ve-silo/contracts/voting-escrow/VotingEscrowRemapper.sol |
| ./ve-silo/contracts/voting-escrow/interfaces/ISmartWalletChecker.sol |
| ./ve-silo/contracts/voting-escrow/interfaces/IVeBoost.sol |
| ./ve-silo/contracts/voting-escrow/interfaces/IVeSilo.sol |
| ./ve-silo/contracts/voting-escrow/interfaces/IVeSiloDelegatorViaCCIP.sol |
| ./ve-silo/contracts/voting-escrow/interfaces/IVotingEscrowCCIPRemapper.sol |
| ./ve-silo/contracts/voting-escrow/interfaces/IVotingEscrowChildChain.sol |
| ./ve-silo/contracts/voting-escrow/interfaces/IVotingEscrowDelegationProxy.sol |
| ./ve-silo/deploy/BatchGaugeCheckpointerDeploy.s.sol |
| ./ve-silo/deploy/CCIPGaugeArbitrumDeploy.sol |
| ./ve-silo/deploy/CCIPGaugeArbitrumUpgradeableBeaconDeploy.sol |
| ./ve-silo/deploy/CCIPGaugeCheckpointerDeploy.s.sol |
| ./ve-silo/deploy/CCIPGaugeFactoryArbitrumDeploy.sol |
| ./ve-silo/deploy/ChildChainGaugeFactoryDeploy.s.sol |
| ./ve-silo/deploy/FeeDistributorDeploy.s.sol |
| ./ve-silo/deploy/FeeSwapperDeploy.s.sol |
| ./ve-silo/deploy/GaugeAdderDeploy.s.sol |
| ./ve-silo/deploy/GaugeControllerDeploy.s.sol |
| ./ve-silo/deploy/L2BalancerPseudoMinterDeploy.s.sol |
| ./ve-silo/deploy/L2Deploy.s.sol |
| ./ve-silo/deploy/LiquidityGaugeFactoryDeploy.s.sol |
| ./ve-silo/deploy/MainnetBalancerMinterDeploy.s.sol |
| ./ve-silo/deploy/MainnetDeploy.s.sol |
| ./ve-silo/deploy/MiloTokenChildChainDeploy.s.sol |
| ./ve-silo/deploy/MiloTokenDeploy.s.sol |
| ./ve-silo/deploy/SiloGovernorDeploy.s.sol |
| ./ve-silo/deploy/SmartWalletCheckerDeploy.s.sol |
| ./ve-silo/deploy/StakelessGaugeCheckpointerAdaptorDeploy.s.sol |
| ./ve-silo/deploy/TimelockControllerDeploy.s.sol |
| ./ve-silo/deploy/UniswapSwapperDeploy.s.sol |
| ./ve-silo/deploy/VeBoostDeploy.s.sol |
| ./ve-silo/deploy/VeSiloDelegatorViaCCIPDeploy.s.sol |
| ./ve-silo/deploy/VotingEscrowChildChainDeploy.s.sol |
| ./ve-silo/deploy/VotingEscrowDelegationProxyDeploy.s.sol |
| ./ve-silo/deploy/VotingEscrowDeploy.s.sol |
| ./ve-silo/deploy/VotingEscrowRemapperDeploy.s.sol |
| ./ve-silo/deploy/_CommonDeploy.sol |
| ./ve-silo/deploy/gauges/GaugeDeployScript.sol |
| ./ve-silo/deploy/gauges/child-chain-gauge/ChildChainGaugeConfigsParser.sol |
| ./ve-silo/deploy/gauges/child-chain-gauge/ChildChainGaugeDeployer.s.sol |
| ./ve-silo/deploy/gauges/child-chain-gauge/ChildChainGaugesDeployments.sol |
| ./ve-silo/deploy/gauges/liquidity-gauge/LiquidityGaugeConfigsParser.sol |
| ./ve-silo/deploy/gauges/liquidity-gauge/LiquidityGaugeDeployer.s.sol |
| ./ve-silo/deploy/gauges/liquidity-gauge/LiquidityGaugesDeployments.sol |
| ./ve-silo/test/L2.integration.t.sol |
| ./ve-silo/test/Mainnet.integration.t.sol |
| ./ve-silo/test/_mocks/BaseGaugeFactoryMock.sol |
| ./ve-silo/test/_mocks/CCIPGaugeFactoryAnyChain.sol |
| ./ve-silo/test/_mocks/CCIPGaugeSepoliaMumbai.sol |
| ./ve-silo/test/_mocks/CheckpointerAdaptorMock.sol |
| ./ve-silo/test/_mocks/ERC20Mint.sol |
| ./ve-silo/test/_mocks/GaugeForCheckpointMock.sol |
| ./ve-silo/test/_mocks/ISiloMock.sol |
| ./ve-silo/test/_mocks/for-testnet-deployments/L2WithMock.integration.t.sol |
| ./ve-silo/test/_mocks/for-testnet-deployments/MainnetWithMocks.integration.t.sol |
| ./ve-silo/test/_mocks/for-testnet-deployments/ccip/CCIPRouterClientLike.sol |
| ./ve-silo/test/_mocks/for-testnet-deployments/ccip/CCIPRouterReceiverLike.sol |
| ./ve-silo/test/_mocks/for-testnet-deployments/deployments/CCIPGaugeFactoryAnyChainDeploy.s.sol |
| ./ve-silo/test/_mocks/for-testnet-deployments/deployments/CCIPGaugeWithMocksDeploy.s.sol |
| ./ve-silo/test/_mocks/for-testnet-deployments/deployments/CCIPRouterClientLikeDeploy.s.sol |
| ./ve-silo/test/_mocks/for-testnet-deployments/deployments/CCIPRouterReceiverLikeDeploy.s.sol |
| ./ve-silo/test/_mocks/for-testnet-deployments/deployments/L2WithMocksDeploy.s.sol |
| ./ve-silo/test/_mocks/for-testnet-deployments/deployments/MainnetWithMocksDeploy.s.sol |
| ./ve-silo/test/_mocks/for-testnet-deployments/deployments/TestTokensChildChainLikeDeploy.s.sol |
| ./ve-silo/test/_mocks/for-testnet-deployments/deployments/TestTokensMainnetLikeDeploy.s.sol |
| ./ve-silo/test/_mocks/for-testnet-deployments/deployments/VeSiloMocksContracts.sol |
| ./ve-silo/test/_mocks/for-testnet-deployments/gauges/CCIPGaugeWithMocks.sol |
| ./ve-silo/test/_mocks/for-testnet-deployments/proposals/SIPV2GaugeSetUpWithMocks.sol |
| ./ve-silo/test/_mocks/for-testnet-deployments/proposals/SIPV2GaugeWeightWithMocks.sol |
| ./ve-silo/test/_mocks/for-testnet-deployments/proposals/SIPV2InitWithMocks.sol |
| ./ve-silo/test/_mocks/for-testnet-deployments/scripts/ApproveAndGetVeSilo.sol |
| ./ve-silo/test/_mocks/for-testnet-deployments/scripts/CastVote.sol |
| ./ve-silo/test/_mocks/for-testnet-deployments/scripts/ExecuteInitWithMocksProposal.sol |
| ./ve-silo/test/_mocks/for-testnet-deployments/scripts/ProposalDetails.sol |
| ./ve-silo/test/_mocks/for-testnet-deployments/scripts/QueueInitWithMocksProposal.sol |
| ./ve-silo/test/_mocks/for-testnet-deployments/scripts/SendEthToProposer.sol |
| ./ve-silo/test/_mocks/for-testnet-deployments/scripts/TransferSiloMockOwnership.sol |
| ./ve-silo/test/_mocks/for-testnet-deployments/scripts/UserDetails.sol |
| ./ve-silo/test/_mocks/for-testnet-deployments/tokens/LINKTokenLike.sol |
| ./ve-silo/test/_mocks/for-testnet-deployments/tokens/SILOTokenLike.sol |
| ./ve-silo/test/fee-dustribution/FeeDistributor.integration.t.sol |
| ./ve-silo/test/fee-dustribution/FeeSwapper.integration.t.sol |
| ./ve-silo/test/fee-dustribution/UniswapSwapper.integration..sol |
| ./ve-silo/test/gauge-controller/GaugeController.unit.t.sol |
| ./ve-silo/test/gauges/BaseGaugeFactory.unit.t.sol |
| ./ve-silo/test/gauges/BatchGaugeCheckpointer.unit.t.sol |
| ./ve-silo/test/gauges/CCIPGauge.integration.t.sol |
| ./ve-silo/test/gauges/CCIPGaugeCheckpointer.integration.t.sol |
| ./ve-silo/test/gauges/CCIPTransferMessageLib.sol |
| ./ve-silo/test/gauges/ChildChainGauges.integration.t.sol |
| ./ve-silo/test/gauges/GaugeAdder.unit.t.sol |
| ./ve-silo/test/gauges/LiquidityGauges.integration.t.sol |
| ./ve-silo/test/gauges/StakelessGaugeCheckpointerAdaptor.unit.t.sol |
| ./ve-silo/test/gauges/interfaces/IChainlinkPriceFeedLike.sol |
| ./ve-silo/test/gauges/interfaces/IMinterLike.sol |
| ./ve-silo/test/gauges/interfaces/IVotingEscrowDelegationProxyLike.sol |
| ./ve-silo/test/governance/ChildChainTokenTest.t.sol |
| ./ve-silo/test/governance/MiloChildChainTokenTest.t.sol |
| ./ve-silo/test/governance/MiloTokenTest.t.sol |
| ./ve-silo/test/governance/SiloGovernor.integration.t.sol |
| ./ve-silo/test/governance/TokenTest.t.sol |
| ./ve-silo/test/proposals/VETSIP01.sol |
| ./ve-silo/test/silo-tokens-minter/BalancerTokenAdmin.uint.t.sol |
| ./ve-silo/test/silo-tokens-minter/FeesManager.unit.t.sol |
| ./ve-silo/test/silo-tokens-minter/L2BalancerPseudoMinter.unit.t.sol |
| ./ve-silo/test/silo-tokens-minter/MainnetBalancerMinter.integration.t.sol |
| ./ve-silo/test/voting-escrow/SmartWalletChecker.unit.t.sol |
| ./ve-silo/test/voting-escrow/VeBoostV2.unit.t.sol |
| ./ve-silo/test/voting-escrow/VeSiloDelegatorViaCCIP.integration.t.sol |
| ./ve-silo/test/voting-escrow/VotingEscrow.integration.t.sol |
| ./ve-silo/test/voting-escrow/VotingEscrowChildChain.unit.t.sol |
| ./ve-silo/test/voting-escrow/VotingEscrowDelegationProxy.unit.t.sol |
| ./ve-silo/test/voting-escrow/VotingEscrowRemapper.integration.t.sol |
| Totals: 1375 |


## Miscellaneous
Employees of Silo Finance and employees' family members are ineligible to participate in this audit.

Code4rena's rules cannot be overridden by the contents of this README. In case of doubt, please check with C4 staff.
