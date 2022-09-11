// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "../interfaces/IController.sol";
import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
abstract contract BaseController is Context, AccessControlEnumerable, IController {

    address public repository;
    address public resolver;

    bytes32 public constant OPERATOR_ROLE = keccak256("OPERATOR_ROLE");

    constructor(address _repo, address _resolver) {
        repository = _repo;
        resolver = _resolver;
        _setupRole(OPERATOR_ROLE, msg.sender);
        _grantRole(OPERATOR_ROLE, msg.sender);
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function Name() external override returns (string memory) {}

    function ID() external override returns (bytes32) {}

    function Operator() external override returns (address) {}

    function authorise(address user) external override {}

    function isAuthorised(address user) external override returns (bool) {}

    function execute() external override {}
}