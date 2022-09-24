// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./BaseController.sol";
import "@openzeppelin/contracts/utils/Address.sol";

contract RootController is BaseController {

    using Address for address;

    constructor(address impl_) BaseController(impl_) {}

    function _beforeRequest(Request memory req) internal virtual override {}

    function _executeRequest(Request memory req) internal virtual override {
        bytes memory responseData = getImplementation().functionDelegateCall(req.params, "root controller request failed")[req.func];
    }




}