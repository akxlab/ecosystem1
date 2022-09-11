// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

uint constant BASE_PRICE_MATIC = 0.15 ether;
uint constant BASE_FEE_PERCENT = 0.1 ether;
uint constant MANTISSA = 1e6;

abstract contract LibMath {

    function calculateTokenQty(uint256 maticsAmount) public view returns(uint256) {
        uint256 base = BASE_PRICE_MATIC;
        return maticsAmount * 1e18 / base;
    }

    function calculateFee(uint256 qty) public view returns(uint256) {
        uint256 base = BASE_FEE_PERCENT;
        uint256 baseQty = MANTISSA;
        return qty * base / 1e18;
    }


}