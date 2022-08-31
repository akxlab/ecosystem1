// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "./EIP1155UReceiver.sol";

contract EIP1155UHolder is EIP1155UReceiver {
    function onEIP1155UReceived(
        address,
        address,
        bytes32,
        bytes memory
    ) public virtual  override returns (bytes4) {
        return this.onEIP1155UReceived.selector;
    }

    function onEIP1155UBatchReceived(
        address,
        address,
        bytes32[] memory,
        bytes calldata
    ) public virtual override returns (bytes4) {
                return this.onEIP1155UBatchReceived.selector;

    }

  
}