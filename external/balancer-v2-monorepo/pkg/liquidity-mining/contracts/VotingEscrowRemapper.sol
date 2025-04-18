// SPDX-License-Identifier: GPL-3.0-or-later
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

pragma solidity ^0.7.0;
pragma experimental ABIEncoderV2;

import "@balancer-labs/v2-interfaces/contracts/solidity-utils/openzeppelin/IERC20.sol";
import "@balancer-labs/v2-interfaces/contracts/liquidity-mining/IOmniVotingEscrow.sol";
import "@balancer-labs/v2-interfaces/contracts/liquidity-mining/IVotingEscrow.sol";

import "@balancer-labs/v2-solidity-utils/contracts/openzeppelin/Address.sol";
import "@balancer-labs/v2-solidity-utils/contracts/openzeppelin/ReentrancyGuard.sol";
import "@balancer-labs/v2-solidity-utils/contracts/helpers/SingletonAuthentication.sol";

/**
 * @notice This contract allows veBAL holders on Ethereum to assign their balance to designated addresses on each L2.
 * This is intended for smart contracts that are not deployed to the same address on all networks. EOA's are
 * expected to either use the same address, or manage delegation on L2 networks themselves.
 *
 * @dev For each network (chainId), we maintain a mapping between local (Ethereum) and remote (L2) addresses.
 * This contract remaps balance queries on remote network addresses to their corresponding local addresses.
 * Users able to call this contract can set their own mappings, or delegate this function to another account if they
 * cannot.
 */
contract VotingEscrowRemapper is SingletonAuthentication, ReentrancyGuard {
    IVotingEscrow private immutable _votingEscrow;
    IOmniVotingEscrow private _omniVotingEscrow;
    mapping(uint256 => mapping(address => address)) private _localToRemoteAddressMap;
    mapping(uint256 => mapping(address => address)) private _remoteToLocalAddressMap;

    // Records a mapping from an address to another address which is authorized to manage its remote users.
    mapping(address => address) private _localRemappingManager;

    event OmniVotingEscrowUpdated(IOmniVotingEscrow indexed newOmniVotingEscrow);
    event AddressMappingUpdated(address indexed localUser, address indexed remoteUser, uint256 indexed chainId);
    event RemoteAddressMappingCleared(address indexed remoteUser, uint256 indexed chainId);
    event AddressDelegateUpdated(address indexed localUser, address indexed delegate);

    constructor(IVotingEscrow votingEscrow, IVault vault) SingletonAuthentication(vault) {
        _votingEscrow = votingEscrow;
    }

    /**
     * @notice Returns Voting Escrow contract address.
     */
    function getVotingEscrow() public view returns (IVotingEscrow) {
        return _votingEscrow;
    }

    /**
     * @notice Returns Omni Voting Escrow contract address).
     */
    function getOmniVotingEscrow() public view returns (IOmniVotingEscrow) {
        return _omniVotingEscrow;
    }

    /**
     * @notice Returns the current total supply of veBAL as a Point.
     * @dev We return the total supply as a Point to allow extrapolating this into the future. Note that this
     * extrapolation will become invalid when crossing weeks, since we're not taking into account veBAL locks that
     * expire then.
     */
    function getTotalSupplyPoint() external view returns (IVotingEscrow.Point memory) {
        IVotingEscrow votingEscrow = getVotingEscrow();
        uint256 totalSupplyEpoch = votingEscrow.epoch();
        return votingEscrow.point_history(totalSupplyEpoch);
    }

    /**
     * @notice Get timestamp when `user`'s lock finishes.
     * @dev The returned value is taken directly from the voting escrow.
     */
    function getLockedEnd(address user) external view returns (uint256) {
        return getVotingEscrow().locked__end(user);
    }

    /**
     * @notice Returns the local user corresponding to an address on a remote chain.
     * @dev Returns `address(0)` if the remapping does not exist for the given remote user.
     * @param remoteUser - Address of the user on the remote chain which are querying the local address for.
     * @param chainId - The chain ID of the network which this user is on.
     */
    function getLocalUser(address remoteUser, uint256 chainId) public view returns (address) {
        return _remoteToLocalAddressMap[chainId][remoteUser];
    }

    /**
     * @notice Returns the remote user corresponding to an address on the local chain.
     * @dev Returns `address(0)` if the remapping does not exist for the given local user.
     * @param localUser - Address of the user on the local chain which are querying the remote address for.
     * @param chainId - The chain ID of the network which the remote user is on.
     */
    function getRemoteUser(address localUser, uint256 chainId) public view returns (address) {
        return _localToRemoteAddressMap[chainId][localUser];
    }

    function getRemappingManager(address localUser) public view returns (address) {
        return _localRemappingManager[localUser];
    }

    function setOmniVotingEscrow(IOmniVotingEscrow omniVotingEscrow) external authenticate nonReentrant {
        _omniVotingEscrow = omniVotingEscrow;
        emit OmniVotingEscrowUpdated(omniVotingEscrow);
    }

    // Remapping Setters

    /**
     * @notice Sets up a mapping from `localUser`'s veBAL balance to `remoteUser` for chain `chainId`.
     * @dev In order to set up a remapping on this contract, `localUser` must be a smart contract which has been
     * allowlisted to hold veBAL. EOAs are expected to set up any delegation of their veBAL on L2s directly.
     * @param localUser - The address of a contract allowlisted on the `SmartWalletChecker`.
     * @param remoteUser - The address to receive `localUser`'s balance of veBAL on the remote chain.
     * @param chainId - The chain id of the remote chain on which `remoteUser` resides.
     */
    function setNetworkRemapping(address localUser, address remoteUser, uint256 chainId) external payable nonReentrant {
        _require(msg.sender == localUser || msg.sender == _localRemappingManager[localUser], Errors.SENDER_NOT_ALLOWED);
        require(_isAllowedContract(localUser), "Only contracts which can hold veBAL can set up a mapping");
        require(remoteUser != address(0), "Zero address cannot be used as remote user");
        IOmniVotingEscrow omniVotingEscrow = getOmniVotingEscrow();
        require(address(omniVotingEscrow) != address(0), "Omni voting escrow not set");

        // We keep a 1-to-1 local-remote mapping for each chain.
        // If A --> B (i.e. A in the local chain is remapped to B in the remote chain), to keep the state consistent
        // the user effectively 'owns' both A and B in both chains.
        //
        // This means that whenever a new remapping is created (assuming A --> B previously):
        // - The remote address must not already be in use by another local user (C --> B is forbidden).
        // - The remote address must not be a local address that has already been remapped (C --> A is forbidden).
        // - The local address must not be the target remote address for another local user (B --> C is forbidden).
        //
        // Note that this means that it is possible to frontrun this call to grief a user by taking up their
        // selected remote address before they do so. This is mitigated somewhat by restricting potential attackers to
        // the set of contracts that are allowlisted to hold veBAL (and their remapping managers). Should
        // one of them grief, then Balancer governance can remove them from these allowlists.

        // B cannot be remapped to (i.e. be a remote) if a prior A --> B mapping exists.
        // To prevent it, we verify that the reverse mapping of our remote does not exist.
        require(
            _remoteToLocalAddressMap[chainId][remoteUser] == address(0),
            "Cannot overwrite an existing mapping by another user"
        );

        // A cannot be remapped to (i.e. be a remote) if a prior A --> B mapping exists.
        // To prevent it, we verify that the mapping of our remote does not exist.
        require(
            _localToRemoteAddressMap[chainId][remoteUser] == address(0),
            "Cannot remap to an address that is in use locally"
        );

        // B cannot be mapped from (i.e. be a local) if a prior A --> B mapping exists.
        // To prevent it, we verify that the reverse mapping of our local does not exist.
        require(
            _remoteToLocalAddressMap[chainId][localUser] == address(0),
            "Cannot remap to an address that is in use remotely"
        );

        // This is a best-effort check: we should not allow griefing the existing balance of an account,
        // because with this remapping we would overwrite it in the target chain ID.
        require(_votingEscrow.balanceOf(remoteUser) == 0, "Target remote address has non-zero veBAL balance");

        // Clear out the old remote user to avoid orphaned entries.
        address oldRemoteUser = _localToRemoteAddressMap[chainId][localUser];
        if (oldRemoteUser != address(0)) {
            _remoteToLocalAddressMap[chainId][oldRemoteUser] = address(0);
            emit RemoteAddressMappingCleared(oldRemoteUser, chainId);
        }

        // Set up new remapping.
        _remoteToLocalAddressMap[chainId][remoteUser] = localUser;
        _localToRemoteAddressMap[chainId][localUser] = remoteUser;

        emit AddressMappingUpdated(localUser, remoteUser, uint16(chainId));

        // Note: it is important to perform the bridge calls _after_ the mappings are settled, since the
        // omni voting escrow will rely on the correct mappings to bridge the balances.
        (uint256 nativeFee, ) = omniVotingEscrow.estimateSendUserBalance(uint16(chainId), false, "");
        if (oldRemoteUser != address(0)) {
            require(msg.value >= nativeFee * 2, "Insufficient ETH to bridge user balance");
            // If there was an old mapping, send balance from (local) oldRemoteUser --> (remote) oldRemoteUser
            // This should clean up the existing bridged balance from localUser --> oldRemoteUser.
            omniVotingEscrow.sendUserBalance{value: nativeFee}(
                oldRemoteUser,
                uint16(chainId),
                payable(msg.sender),
                address(0),
                ""
            );
        } else {
            require(msg.value >= nativeFee, "Insufficient ETH to bridge user balance");
        }

        // Bridge balance for new mapping localUser --> remoteUser.
        omniVotingEscrow.sendUserBalance{value: nativeFee}(
            localUser,
            uint16(chainId),
            payable(msg.sender),
            address(0),
            ""
        );

        // Send back any leftover ETH to the caller.
        uint256 remainingBalance = address(this).balance;
        if (remainingBalance > 0) {
            Address.sendValue(msg.sender, remainingBalance);
        }
    }

    /**
     * @notice Sets an address to manage the mapping for a given local user on its behalf.
     * @dev This is intended to handle contracts which cannot interact with this contract directly.
     * @param localUser - The address of a contract allowlisted on the `SmartWalletChecker`.
     * @param delegate - The address which is allowed to manage remote users to be linked to `localUser`.
     */
    function setNetworkRemappingManager(address localUser, address delegate) external authenticate nonReentrant {
        require(_isAllowedContract(localUser), "Only contracts which can hold veBAL may have a delegate");

        _localRemappingManager[localUser] = delegate;
        emit AddressDelegateUpdated(localUser, delegate);
    }

    /**
     * @notice Clears a local user's mapping for a particular network.
     * @dev This is intended to discourage and also allow recovery from griefing attacks.
     * If griefing occurs then the griefer can be removed from Smart Wallet Checker and have their remappings erased.
     * The local user can always clear its own mapping, regardless the state of the Smart Wallet Checker.
     * @param localUser - The address of the local user to erase.
     * @param chainId - The chain id of the network to erase.
     */
    function clearNetworkRemapping(address localUser, uint256 chainId) external payable nonReentrant {
        require(localUser != address(0), "localUser cannot be zero address");
        require(!_isAllowedContract(localUser) || localUser == msg.sender, "localUser is still in good standing");
        IOmniVotingEscrow omniVotingEscrow = getOmniVotingEscrow();
        require(address(omniVotingEscrow) != address(0), "Omni voting escrow not set");

        address remoteUser = _localToRemoteAddressMap[chainId][localUser];
        require(remoteUser != address(0), "Remapping to clear does not exist");

        _remoteToLocalAddressMap[chainId][remoteUser] = address(0);
        _localToRemoteAddressMap[chainId][localUser] = address(0);

        emit AddressMappingUpdated(localUser, address(0), chainId);
        emit RemoteAddressMappingCleared(remoteUser, chainId);

        // Note: it is important to perform the bridge calls _after_ the mappings are settled, since the
        // omni voting escrow will rely on the correct mappings to bridge the balances.
        // Clean up the balance for the old mapping, and bridge the new (default) one.
        (uint256 nativeFee, ) = omniVotingEscrow.estimateSendUserBalance(uint16(chainId), false, "");
        require(msg.value >= nativeFee * 2, "Insufficient ETH to bridge user balance");

        omniVotingEscrow.sendUserBalance{value: nativeFee}(
            localUser,
            uint16(chainId),
            payable(msg.sender),
            address(0),
            ""
        );
        omniVotingEscrow.sendUserBalance{value: nativeFee}(
            remoteUser,
            uint16(chainId),
            payable(msg.sender),
            address(0),
            ""
        );

        // Send back any leftover ETH to the caller.
        uint256 remainingBalance = address(this).balance;
        if (remainingBalance > 0) {
            Address.sendValue(msg.sender, remainingBalance);
        }
    }

    // Internal Functions

    /**
     * @notice Returns whether `localUser` is a contract which is authorized to hold veBAL.
     * @param localUser - The address to check against the `SmartWalletChecker`.
     */
    function _isAllowedContract(address localUser) private view returns (bool) {
        ISmartWalletChecker smartWalletChecker = getVotingEscrow().smart_wallet_checker();
        return smartWalletChecker.check(localUser);
    }
}
