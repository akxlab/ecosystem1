// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Votes.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Snapshot.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "../Roles.sol";


contract AKX3 is ERC20, ERC20Burnable, ERC20Permit, ERC20Votes, ERC20Snapshot, AccessControlEnumerable, ReentrancyGuard, AKXRoles {

bool canTransfer;
    constructor() ERC20("AKX3 ECOSYSTEM", "AKX") ERC20Permit("AKX3 ECOSYSTEM") {
        canTransfer = false;
        initRoles();
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
        _grantRole(AKX_OPERATOR_ROLE, _msgSender());
        
    }

    function mint(address _sender, uint256 amount) public onlyRole(AKX_OPERATOR_ROLE) {
    _mint(_sender, amount);
    }

    
 function _afterTokenTransfer(address from, address to, uint256 amount)
        internal
        override(ERC20, ERC20Votes)
    {
        super._afterTokenTransfer(from, to, amount);
    }

     function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        override(ERC20, ERC20Snapshot)
    {
        super._afterTokenTransfer(from, to, amount);
    }

 function enableTransfer() public onlyRole(AKX_OPERATOR_ROLE) {
        canTransfer = true;
    }

    modifier isTransferable() {
        require(canTransfer != false || hasRole(AKX_OPERATOR_ROLE, msg.sender), "cannot trade or transfer");
        _;
    }

    function transfer(address _to, uint _value) public isTransferable virtual override returns (bool success) {
        if (_value > 0 && _value <= balanceOf(msg.sender)) {
          return transfer(_to, _value);
        }
       revert("cannot transfer");
    }

     function _mint(address to, uint256 amount)
        internal
        override(ERC20, ERC20Votes)
    {
        super._mint(to, amount);
    }

    function _burn(address account, uint256 amount)
        internal
        override(ERC20, ERC20Votes)
    {
        super._burn(account, amount);
    }

}