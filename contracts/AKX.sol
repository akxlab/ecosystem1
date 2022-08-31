// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "./interfaces/IAKX.sol";

contract AKXEcosystem is IAKX {
    function getModule(bytes32 mName) external override returns (IModule) {}

    function getResolver(Resolvers) external override returns (address) {}

    function getRegistry(Registry) external override returns (address) {}

    function getUser(uint256 tokenId) external override returns (IEIP721U) {}

    function LabzToken() external override returns (address) {}

    function PriceOracle() external override returns (address) {}

    function Pools() external override returns (address[] memory) {}

    function Controller(bytes32 cName) external returns(address) {}
}