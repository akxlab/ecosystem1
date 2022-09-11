// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IERC2055 is IERC20 {

    function safeTransferToken(address from, address to, uint256 amount) external returns(bool transferred);
    function lockToken(uint256 until) external;
    function unlockToken() external;
    function feeEstimate(uint256 amount) external view returns(uint256);

}