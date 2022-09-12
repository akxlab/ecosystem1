// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

abstract contract OrderLogic  {


    enum SALE_TYPE {
        NONE,
        PRIVATE,
        PUBLIC
    }

    struct Order {
        SALE_TYPE _saleType;
        address _token;
        address _to;
        uint256 _amountSent;
        uint256 _userTokenId;
        uint256 _blockNumber;
        uint256 _blockTime;
    }

    function createPrivateOrder(address token, address to, uint256 amount, uint256 userTokenId) internal returns(Order memory o) {
        o = Order(SALE_TYPE.PRIVATE, token, to, amount, userTokenId, block.number, block.timestamp);
    }



}