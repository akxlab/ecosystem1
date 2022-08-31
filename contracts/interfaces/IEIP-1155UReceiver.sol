// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

interface IEIP1155UReceiver {
     /**
     * @dev Handles the receipt of a single ERC1155U token type. This function is
     * called at the end of a `safeTransferFrom` after the balance has been updated.
     *
     * NOTE: To accept the transfer, this must return
     * `bytes4(keccak256("onERC1155UReceived(address,address,bytes32,bytes)"))`
     * (i.e. 0xf23a6e61, or its own function selector).
     *
     * @param operator The address which initiated the transfer (i.e. msg.sender)
     * @param from The address which previously owned the token
     * @param id The ID of the token being transferred
     * @param data Additional data with no specified format
     * @return `bytes4(keccak256("onERC1155UReceived(address,address,bytes32,bytes)"))` if transfer is allowed
     */
    function onEIP1155UReceived(
        address operator,
        address from,
        bytes32 id,
        bytes calldata data
    ) external returns (bytes4);

    /**
     * @dev Handles the receipt of a multiple ERC1155U token types. This function
     * is called at the end of a `safeBatchTransferFrom` after the balances have
     * been updated.
     *
     * NOTE: To accept the transfer(s), this must return
     * `bytes4(keccak256("onERC1155UBatchReceived(address,address,bytes32[],bytes)"))`
     * (i.e. 0xbc197c81, or its own function selector).
     *
     * @param operator The address which initiated the batch transfer (i.e. msg.sender)
     * @param from The address which previously owned the token
     * @param ids An array containing ids of each token being transferred (order and length must match values array)
     * @param data Additional data with no specified format
     * @return `bytes4(keccak256("onERC1155UBatchReceived(address,address,bytes32[],bytes)"))` if transfer is allowed
     */
    function onEIP1155UBatchReceived(
        address operator,
        address from,
        bytes32[] calldata ids,
        bytes calldata data
    ) external returns (bytes4);
}