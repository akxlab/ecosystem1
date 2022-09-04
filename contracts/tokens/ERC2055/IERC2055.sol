// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IERC2055 is IERC20 {

    function onERC2055Receive() external;

    function safeMint(address tokenAddress, address to) external returns(bool);
    function upgradeERC20ToERC2055(address tokenAddress1) external returns(IERC2055);
    function safeBurn(uint256 amount, address to) external returns(bool);
    function safeTransferToken(address from, address to, uint256 amount) external returns(bool transferred);
    function lockToken(uint256 until) external;
    function unlockToken() external;


    function supportedTokenInterfaces(bytes4 interfaceID) external view returns(bool);


}