// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

    enum SALE_TYPE {
        NONE,
        PRIVATE,
        PUBLIC
    }

abstract contract OrderLogic {
    struct Order {
        SALE_TYPE _saleType;
        address _token;
        address _from;
        uint256 _amountSent;
        uint256 _userTokenId;
        uint256 _blockNumber;
        uint256 _blockTime;
        bytes32 _orderHash;
    }

}