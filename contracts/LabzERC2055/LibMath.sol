// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

uint constant BASE_PRICE_MATIC = 0.15 ether;
uint constant BASE_FEE_PERCENT = 10000000;
uint constant MANTISSA = 1e6;

library LibMath {

    function calculateTokenQty(uint256 maticsAmount) public view returns(uint256) {
        uint256 base = BASE_PRICE_MATIC;
        return maticsAmount / base;
    }

    function calculateFee(uint256 qty) public view returns(uint256) {
        uint256 base = BASE_FEE_PERCENT;
        uint256 baseQty = MANTISSA;
        return qty * baseQty * base / MANTISSA;
    }


}