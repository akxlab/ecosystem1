// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "./BaseResolver.sol";

abstract contract NameResolver is BaseResolver {
   
   bytes4 constant private NAME_INTERFACE_ID = 0x00ad800c;

   mapping(uint256 => string) private _names; // external user identifier
   
    function name(uint256 tokenId) external view returns (string memory) {
        return _names[tokenId];
    }

    function supportsInterface(bytes4 interfaceID) virtual override public pure returns(bool) {
        return interfaceID == NAME_INTERFACE_ID || super.supportsInterface(interfaceID);
    }
}