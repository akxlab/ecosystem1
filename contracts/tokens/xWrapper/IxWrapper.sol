// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IxWrapper {

    event NewTokenWrapped(address _token);

    function wrap() external returns (address);
    function wrapERC721(address _implementation) external returns (address);
    function wrapERC1155(address _implementation) external returns (address);
    function wrapERC20(address _implementation) external returns(address);


}