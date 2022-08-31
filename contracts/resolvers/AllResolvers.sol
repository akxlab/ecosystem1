// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "./IdentResolver.sol";
import "./NameResolver.sol";
import "./ProfileResolver.sol";
import "./MetaDataResolver.sol";

abstract contract AllResolvers is IdentResolver, NameResolver, ProfileResolver, MetaDataResolver {
  function supportsInterface(bytes4 interfaceID) virtual override(IdentResolver, MetaDataResolver, NameResolver, ProfileResolver) public pure returns(bool) {
        return super.supportsInterface(interfaceID);
    }
}