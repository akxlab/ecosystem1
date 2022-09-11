// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IxToken  {
    function tokenType() external returns(string memory);
    function mintable() external returns(bool);
    function burnable() external returns(bool);
    function safeTransferToken(address to, uint256 amount) external;
    function safeTransferToken(address from, address to, uint256 amount) external;
    function lockToken(uint256 until) external;
    function unlockToken() external;
    function xTokenName() external returns(string memory);
    function xTokenSymbol() external returns(string memory);
    function xTokenSupply() external returns(uint256);
    function xTokenPrice() external returns(uint256);
}