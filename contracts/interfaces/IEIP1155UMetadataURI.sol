// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import "./IEIP-1155U.sol";

/**
 * @dev Interface of the optional ERC1155UMetadataExtension interface, as defined
 * 
 */
interface IEIP1155UMetadataURI is IEIP1155U {
    /**
     * @dev Returns the URI for token type `id`.
     *
     * If the `\{id\}` substring is present in the URI, it must be replaced by
     * clients with the actual token type ID.
     */
    function uri(uint256 id) external view returns (string memory);
}
