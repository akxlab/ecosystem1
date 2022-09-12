// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

uint constant BASE_PRICE_MATIC = 0.15 ether;
uint constant BASE_FEE_PERCENT = 0.1 ether;
uint constant MANTISSA = 1e6;

abstract contract LibMath {

    function calculateTokenQty(uint256 maticsAmount) public pure returns(uint256) {
        uint256 base = BASE_PRICE_MATIC;
        return mul(maticsAmount, 1e18) / base;
    }

    function calculateFee(uint256 qty) public pure returns(uint256) {
        uint256 base = BASE_FEE_PERCENT;
        //uint256 baseQty = MANTISSA;
        return mul(qty, base) / 1e18;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-solidity/pull/522
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b);

        return c;
    }

    /**
     * @dev Subtracts two numbers, reverts on overflow (i.e. if subtrahend is greater than minuend).
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a);
        uint256 c = a - b;

        return c;
    }

    /**
     * @dev Adds two numbers, reverts on overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a);

        return c;
    }

    /**
     * @dev Returns the largest of two numbers.
     */
    function max(uint256 a, uint256 b) internal pure returns (uint256) {
        return a >= b ? a : b;
    }


}