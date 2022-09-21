// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

import "@openzeppelin/contracts/access/Ownable.sol";

contract LabzERC20 is ERC20, ERC20Permit, ReentrancyGuard, Ownable {

    bool public canTransfer;

    mapping(address => uint256) private  _balanceOf;

    constructor() ERC20("LABZ (AKX3 Token)", "LABZ") ERC20Permit("LABZ (AKX3 Token)") {

        canTransfer = false;

    }

    function mint(address _to, uint256 _amount) public onlyOwner returns(uint256) {
        super._mint(_to, _amount);
        return _amount;
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
            _balanceOf[msg.sender] -= _value;
            _balanceOf[_to] += _value;
            emit Transfer(msg.sender, _to, _value);
            return true;
        }
        return false;
    }



}