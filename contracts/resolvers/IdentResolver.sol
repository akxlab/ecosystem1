// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "./BaseResolver.sol";

abstract contract IdentResolver is BaseResolver {
   
   bytes4 constant private IDENT_INTERFACE_ID = 0x0e2f9f10;

   mapping(uint256 => string) private _idents; // external user identifier for ie database
   
    function ident(uint256 tokenId) external view returns (string memory) {
        return _idents[tokenId];
    }

    function supportsInterface(bytes4 interfaceID) virtual override public pure returns(bool) {
        return interfaceID == IDENT_INTERFACE_ID || super.supportsInterface(interfaceID);
    }
}