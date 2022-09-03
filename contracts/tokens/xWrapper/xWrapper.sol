// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "./IxWrapper.sol";
import "./IxToken.sol";
import "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/utils/Context.sol";

import "@openzeppelin/contracts/proxy/Clones.sol";

contract xWrapper is Initializable, Context, IxWrapper {

    address private implementation;
    uint private _ercType;
    bool private _isPresale;
    IxToken private token;
    address private owner;
    bytes32 private _salt;

    constructor() {

    }

    function initialize(address _owner, address _implementation, uint ercType, bytes32 salt, bool isPresale) public initializer {
        _salt = salt;
        owner = _owner;
        implementation = _implementation;
        _ercType = ercType;
        _isPresale = isPresale;
    }

    function wrap() external onlyInitializing override returns (address) {
        if(_ercType == 20) {
            return this.wrapERC20(implementation);
        }
        if(_ercType == 721) {
            return this.wrapERC721(implementation);
        }
        if(_ercType == 1155) {
            return this.wrapERC1155(implementation);
        }
        revert("type not supported");
    }


    function wrapERC721(address _implementation)
        external
        override
        returns (address)
    {}

    function wrapERC1155(address _implementation)
        external
        override
        returns (address)
    {}

    function wrapERC20(address _implementation)
        external
        override
        returns (address)
    {}
}