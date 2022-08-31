// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

interface IPool {
    event PoolCreated(address _owner, address indexed token1, address indexed token2);
    event PoolRemoved(address indexed token1, address indexed token2);

    function addLiquidity(uint256 amount1, uint256 amount2) external;
    function removeLiquidity(uint256 amount) external;
    function calcPrice(address poolAddress) external returns(uint256);
    function getPools(address token) external returns(uint256[] memory);
    function getPoolById(uint256 tokenId) external returns(Pool memory);
    function newPool(address token1, address token2, uint256 amount1, uint256 amount2, uint256 fees) external;
    function swap(address token1, address token2, uint256 amount) external;

    struct Pool {
        address token1;
        address token2;
        uint256 liq1;
        uint256 liq2;
        uint256 ratio;
        uint128 ticks;
    }

}