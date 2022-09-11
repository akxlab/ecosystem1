// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@openzeppelin/contracts/utils/introspection/IERC165.sol";
interface IController is IERC165 {

    function Name() external returns(string memory);

    function ID() external returns(bytes32);

    function Operator() external returns(address);

    function authorise(address user) external;

    function isAuthorised(address user) external returns(bool);

    function execute() external;

}