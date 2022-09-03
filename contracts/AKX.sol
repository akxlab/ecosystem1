// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "./interfaces/IAKX.sol";

contract AKXEcosystem is IAKX {
    function EthDIDRegistry() external override returns (DidRegistry) {}
}