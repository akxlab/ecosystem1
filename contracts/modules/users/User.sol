// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "../../interfaces/IUser.sol";

abstract contract User is IUser {
    
    function balanceOf(address _owner, uint256 _id) external override {}

    
    function mint(address _to) external override returns (uint256) {}

    function burn(address _from, address _to)
        external
        override
        returns (uint256)
    {}

    function recover(address _from, bytes calldata _recoveryData)
        external
        override
        returns (bool)
    {}

    function sha() external override {}
}