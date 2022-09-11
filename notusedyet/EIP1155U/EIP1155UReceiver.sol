// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "../../interfaces/IEIP-1155UReceiver.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";

abstract contract EIP1155UReceiver is ERC165, IEIP1155UReceiver {
    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC165) returns (bool) {
        return interfaceId == type(IEIP1155UReceiver).interfaceId || super.supportsInterface(interfaceId);
    }
}
