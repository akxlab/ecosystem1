// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "./BaseResolver.sol";

abstract contract ProfileResolver is BaseResolver {

   bytes4 constant private PROFILE_INTERFACE_ID = 0x72cd2b1a;

   mapping(uint256 => bytes32) private _profiles;

    function profile(uint256 tokenId) public view returns(bytes32) {
        return _profiles[tokenId];
    }

     function supportsInterface(bytes4 interfaceID) virtual override public pure returns(bool) {
        return interfaceID == PROFILE_INTERFACE_ID || super.supportsInterface(interfaceID);
    }


}