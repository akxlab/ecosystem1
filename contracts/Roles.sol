// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

bytes32 constant OPERATOR_ROLE = keccak256(abi.encodePacked("OPERATOR_ROLE"));
bytes32 constant MINTER_ROLE = keccak256(abi.encodePacked("MINTER_ROLE"));
bytes32 constant REGISTRY_ROLE = keccak256(abi.encodePacked("REGISTRY_ROLE"));
bytes32 constant GATEWAY_ROLE = keccak256(abi.encodePacked("GATEWAY_ROLE"));
bytes32 constant HOLDER_ROLE = keccak256(abi.encodePacked("HOLDER_ROLE"));
bytes32 constant VIP_ROLE = keccak256(abi.encodePacked("VIP_ROLE"));
