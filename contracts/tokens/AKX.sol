// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Snapshot.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

import "@openzeppelin/contracts/access/Ownable.sol";

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";


contract AKX3 is ERC20, ERC20Burnable, ERC20Permit, Ownable, ReentrancyGuard {

bool canTransfer;
    constructor() ERC20("AKX3 ECOSYSTEM", "AKX") ERC20Permit("AKX3 ECOSYSTEM") {
        canTransfer = false;
        
    }

    function mint(address _sender, uint256 amount) public onlyOwner {
        super._mint(_sender, amount);
    }

    function burn(uint256 amount) public override onlyOwner {
       super._burn(address(this), amount);
    }



 function _afterTokenTransfer(address from, address to, uint256 amount)
        internal
        override(ERC20)
    {
        super._afterTokenTransfer(from, to, amount);
    }

 function enableTransfer() public onlyOwner {
        canTransfer = true;
    }

    modifier isTransferable() {
        require(canTransfer != false, "cannot trade or transfer");
        _;
    }

    function transfer(address _to, uint _value) public isTransferable virtual override returns (bool success) {
        if (_value > 0 && _value <= balanceOf(msg.sender)) {
          return transfer(_to, _value);
        }
       revert("cannot transfer");
    }

}