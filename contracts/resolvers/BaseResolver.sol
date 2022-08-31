// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "../utils/BytesUtils.sol";


abstract contract BaseResolver is ERC165, BytesUtils {

bytes4 private constant INTERFACE_META_ID = 0x01ffc9a7;

    function supportsInterface(bytes4 interfaceID) virtual public override pure returns(bool) {
        return interfaceID == INTERFACE_META_ID;
    }

}