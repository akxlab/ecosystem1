// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./BaseController.sol";
import "../interfaces/IEIP721U.sol";

contract UserController is BaseController {

    constructor(address repo, address _resolver) BaseController(repo, _resolver) {

    }

}