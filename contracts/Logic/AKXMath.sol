// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "../utils/LibMath.sol";
import "hardhat/console.sol";

contract AKXMath  {

    using LibMath for uint256;
    using LowGasSafeMath for uint256;
   
    uint256 public MaxFounderPercent = 4 * 1e5;
    uint256 public Reserve = 10 * 1e5;
    uint256 public PreSalePercent = 2 * 1e5;
    uint256 public Operations = 23 * 1e5;
    uint256 public maxCirculating = 46 * 1e5;
    uint256 public mantissa = 1e5;

    function getPercentForFounder(uint256 supply) public returns(uint256) {
        return LibMath.mulDivRoundingUp(supply, MaxFounderPercent, mantissa);
    }


 




}