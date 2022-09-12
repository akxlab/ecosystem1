// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/proxy/Clones.sol";
import "./AkxWallet.sol";

contract AKXWalletFactory {

    event WalletCreated(address newWallet);

    mapping(address => bytes32) internal _salts;
    mapping(bytes32 => bool) internal _saltExists;

    address internal _implementation;

    constructor(address impl) {
        _implementation = impl;
    }

    function createWallet(address _owner, bytes32 _salt) public returns(address newWallet) {
        require(_saltExists[_salt] != true, "invalid salt");
        _saltExists[_salt] = true;
        _salts[_owner] = _salt;
        newWallet = Clones.cloneDeterministic(_implementation, _salt);
        emit WalletCreated(newWallet);
    }

    function belongsTo(address _owner) public view returns(address _wallet) {
        bytes32 _salt = _salts[_owner];
        require(_saltExists[_salt] == true, "unknown owner");
        _wallet = Clones.predictDeterministicAddress(_implementation, _salt);
    }

    function ownerOf(address _wallet) public view returns(bool) {
      return belongsTo(msg.sender) == _wallet;
    }

    function initWallet() public returns(bool isInitialized) {
        address _wallet = belongsTo(msg.sender);
        AkxWallet _w = AkxWallet(payable(_wallet));

        isInitialized = true;

    }

}