// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;



abstract contract AKXRoles {
    bytes32 public constant LABZ_OPERATOR_ROLE = keccak256("LABZ_OPERATOR_ROLE");
    bytes32 public constant AKX_OPERATOR_ROLE = keccak256("AKX_OPERATOR_ROLE");
    bytes32 public constant UDS_OPERATOR_ROLE = keccak256("UDS_OPERATOR_ROLE");
    bytes32 public constant UPGRADER_ROLE = keccak256("UPGRADER_ROLE");
    bytes32 public constant LABZ_HOLDER_ROLE = keccak256("LABZ_HOLDER_ROLE");
    bytes32 public constant AKX_HOLDER_ROLE = keccak256("AKX_HOLDER_ROLE");
    bytes32 public constant DAO_ROLE = keccak256("DAO_ROLE");
     bytes32 public constant SYSADMIN_ROLE = keccak256("SYSADMIN_ROLE");
      bytes32 public constant ADMIN_HELPER_ROLE = keccak256("ADMIN_HELPER_ROLE");
}