// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Snapshot.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

import "@openzeppelin/contracts/access/Ownable.sol";


contract AKX3 is ERC20, ERC20Burnable, ERC20Permit, ERC20Votes, ERC20Snapshot, Ownable, ReentrancyGuard {

    constructor() ERC20("AKX3 ECOSYSTEM", "AKX3") ERC20Permit("AKX3 Token") {

    }

    function swap(address swapToken, uint256 amount) public payable nonReentrant {

    }


    function buy() external payable nonReentrant {

    }

    function sell() external payable nonReentrant {

    }

    function maxSupply() public view virtual returns(uint256) {
        return 100000000 ether; // 100 million max available
    }

    function akxForLabz() public view virtual returns(uint256) {
        return 0.1 ether; // 1 AKX for 10 labz
    }

    function labzForAKX() public view virtual returns(uint256) {
        return 10 ether; // 10 labz for 1 AKX
    }

    function akxForETH() public view virtual returns(uint256) {
        return 0;
    }

    function akxForMatics() public view virtual returns(uint256) {
        return 0;
    }

    function priceETH() public view virtual returns(uint256) {
        return 0;
    }

    function priceMATICS() public view virtual returns(uint256) {
        return 0;
    }

    function prices() public view virtual returns(uint256, uint256) {
        return (priceETH(), priceMATICS());
    }
}