// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.24;

import {Ownable} from "openzeppelin5/access/Ownable.sol";
import {MessageHashUtils} from "openzeppelin5//utils/cryptography/MessageHashUtils.sol";
import {ERC20Permit} from "openzeppelin5/token/ERC20/extensions/ERC20Permit.sol";
import {VmSafe} from "forge-std/Vm.sol";
import {IntegrationTest} from "silo-foundry-utils/networks/IntegrationTest.sol";
import {IAccessControl} from "openzeppelin5/access/IAccessControl.sol";

import {ISiloTokenChildChain} from "ve-silo/contracts/governance/interfaces/ISiloTokenChildChain.sol";
import {MiloTokenDeploy} from "ve-silo/deploy/MiloTokenDeploy.s.sol";
import {BalancerTokenAdmin} from "ve-silo/contracts/silo-tokens-minter/BalancerTokenAdmin.sol";
import {IBalancerToken} from "ve-silo/contracts/silo-tokens-minter/BalancerTokenAdmin.sol";

abstract contract ChildChainTokenTest is IntegrationTest {
    bytes32 internal constant _PERMIT_TYPEHASH =
        keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");

    bytes32 internal constant _TYPE_HASH =
        keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)");

    bytes32 internal constant _HASHED_VERSION = keccak256(bytes("1"));

    ISiloTokenChildChain internal _token;
    address internal _deployer;

    function setUp() public {
        uint256 deployerPrivateKey = uint256(vm.envBytes32("PRIVATE_KEY"));
        _deployer = vm.addr(deployerPrivateKey);

        vm.createSelectFork(getChainRpcUrl(_network()), _forkingBlockNumber());

        _deployToken();
    }

    function testEnsureDeployedWithCorrectConfigurations() public view {
        assertEq(_token.symbol(), _symbol(), "An invalid symbol after deployment");
        assertEq(_token.name(), _name(), "An invalid name after deployment");
        assertEq(_token.decimals(), _decimals(), "An invalid decimals after deployment");
    }

    function testCantMintWithoutRole() public {
        vm.expectRevert(
            abi.encodeWithSelector(
                IAccessControl.AccessControlUnauthorizedAccount.selector,
                address(this),
                _token.BRIDGE_ROLE()
            )
        );

        _token.mint(address(this), 1000);
    }

    function testDeployerIsAdmintAndCanGrantRole() public {
        address ccipTokenPool = makeAddr("CCIP Token Pool");

        bytes32 bridgeRole = _token.BRIDGE_ROLE();

        assertTrue(_token.hasRole(_token.DEFAULT_ADMIN_ROLE(), _deployer), "Deployer is not an admin");
        assertFalse(_token.hasRole(bridgeRole, ccipTokenPool), "CCIP Token Pool has a role");

        vm.prank(_deployer);
        _token.grantRole(bridgeRole, ccipTokenPool);

        assertTrue(_token.hasRole(bridgeRole, ccipTokenPool), "CCIP Token Pool has no role");
    }

    function testBridgeCanMintAndBurn() public {
        assertEq(_token.balanceOf(_deployer), 0, "An invalid balance before minting");

        uint256 tokensAmount = 10_000_000_000e18;
        bytes32 bridgeRole = _token.BRIDGE_ROLE();
        address ccipTokenPool = makeAddr("CCIP Token Pool");

        vm.prank(_deployer);
        _token.grantRole(bridgeRole, ccipTokenPool);

        vm.prank(ccipTokenPool);
        _token.mint(_deployer, tokensAmount);
        assertEq(_token.balanceOf(_deployer), tokensAmount, "An invalid balance after minting");

        // anyone can burn tokens
        vm.prank(_deployer);
        _token.burn(tokensAmount);
    }

    function testTokenPermit() public {
        VmSafe.Wallet memory signer = vm.createWallet("Proof signer");

        address spender = makeAddr("Spender");
        uint256 value = 100e18;
        uint256 nonce = _token.nonces(signer.addr);
        uint256 deadline = block.timestamp + 1000;

        (uint8 v, bytes32 r, bytes32 s) = _createPermit(signer, spender, value, nonce, deadline, address(_token));

        uint256 allowanceBefore = _token.allowance(signer.addr, spender);
        assertEq(allowanceBefore, 0, "expect no allowance");

        _token.permit(signer.addr, spender, value, deadline, v, r, s);

        uint256 allowanceAfter = _token.allowance(signer.addr, spender);
        assertEq(allowanceAfter, value, "expect valid allowance");
    }

    function _deployToken() internal virtual {}

    function _createPermit(
        VmSafe.Wallet memory _signer,
        address _spender,
        uint256 _value,
        uint256 _nonce,
        uint256 _deadline,
        address _shareToken
    ) internal view returns (uint8 v, bytes32 r, bytes32 s) {
        bytes32 structHash = keccak256(abi.encode(_PERMIT_TYPEHASH, _signer.addr, _spender, _value, _nonce, _deadline));

        bytes32 domainSeparator = ERC20Permit(_shareToken).DOMAIN_SEPARATOR();
        bytes32 digest = MessageHashUtils.toTypedDataHash(domainSeparator, structHash);

        (v, r, s) = vm.sign(_signer.privateKey, digest);
    }

    function _hashedName() internal pure returns (bytes32) {
        return keccak256(bytes(_name()));
    }

    function _network() internal pure virtual returns (string memory) {}
    function _forkingBlockNumber() internal pure virtual returns (uint256) {}
    function _symbol() internal pure virtual returns (string memory) {}
    function _name() internal pure virtual returns (string memory) {}
    function _decimals() internal pure virtual returns (uint8) {}
}
