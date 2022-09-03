// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "./xToken.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
contract xTokenERC20 is xToken, ERC20 {

    mapping(address => uint256) private _balances;

    constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol) {}

   

    function transfer(address to, uint256 amount)
        public virtual
        override(ERC20)
        returns (bool)
    {
        this.safeTransferToken(to, amount);
        return true;
    }

   
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public override(ERC20) returns (bool) {
         this.safeTransferToken(from, to, amount);
        return true;
    }
}