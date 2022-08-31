// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;


import "../../interfaces/IUserRegistry.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../../utils/InitModifiers.sol";
import "../../utils/Hashing.sol";

contract UserRegistry is IUserRegistry, Ownable, InitModifiers, Hashing {

    mapping(string => bytes32) private _userResolver;
    mapping(address => bool) private _registry;
    mapping(address => bytes32) private _ids;
    mapping(address => mapping(bytes32 => bool)) private _owners;
    mapping(bytes32 => bool) private _activeUsers;
    mapping(address => bool) private _blacklist;
    mapping(address => bool) private _whitelist;
    mapping(address => bool) private _suspended;
    mapping(bytes32 => User) private _userData;

    bytes32[] private _userHashes;
    bytes32 private _zeroHash;

    using Counters for Counters.Counter;

    Counters.Counter private index;

    constructor() Hashing() Ownable() {
        // no zero index
        index.increment();
        zeroHash();
        _userHashes.push();
        setInitialized();
    }

    /// @dev setting zero hash to make sure no user can have a null / zero address
    function zeroHash() internal onlyNotInitialized {

        _zeroHash = _calculateHash(address(0x0), block.number);

    }

    function registerUser() external override onlyOwner {}

    function deRegisterUser() external override onlyOwner {}

    function suspendUser(address user, bytes32 id) external override onlyOwner {}

    function recoverUser() external override onlyOwner {}

    function verifyUser() external override onlyOwner {}

    function resolve() external override {}

    
}