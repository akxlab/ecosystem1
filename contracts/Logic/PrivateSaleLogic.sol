// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {PrivateBuyingLogic} from "./PrivateBuyingLogic.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Address} from "@openzeppelin/contracts/utils/Address.sol";
import {RefundEscrow} from "@openzeppelin/contracts/utils/escrow/RefundEscrow.sol";
import {LabzERC20} from "../tokens/LabzERC20.sol";
import {LockLogic} from "./LockLogic.sol";

contract PrivateSaleLogic is PrivateBuyingLogic, Ownable {

    address public _saleToken;
    LabzERC20 private _labz;

    using Address for address;

    uint256 public startTime;
    uint256 public maxTokensForPrivateSale;
    uint256 public maxTokensPerAccount;
    uint256 public maxSaleDuration;
    uint256 public totalMinted;
    bool public privateSaleIsStarted;
    address payable public escrowBeneficiary;
    bool public breakIsOn;
    bool public isClosed;

    RefundEscrow private _saleRefundEscrow;

    address public lockLogic;


    constructor(address multiWallet) {
        escrowBeneficiary = payable(multiWallet);
        _saleRefundEscrow = new RefundEscrow(escrowBeneficiary);
        _saleToken = deployLabzToken();
        maxTokensForPrivateSale = 65000000 ether;
        maxTokensPerAccount = 1000000 ether;
        maxSaleDuration = 180 days; // max 6 months 
        restart();
    }

    function deployLabzToken() internal returns(address payable) {
        _labz = new LabzERC20();
        return payable(address(_labz));
    }

    function buy() public payable nonReentrant {
       if(privateSaleIsStarted != true) {
        revert("cannot buy yet");
       }
       if(totalMinted == maxTokensForPrivateSale) {
            closeSale();
       }
       BuyDetails memory _bd = executeBuyLogic(msg.sender, msg.value);
       _labz.mint(_bd.from, _bd.qty);
         // @notice 10% of the transaction is sent to the gnosis multisignature wallet for the reserve as stated in the Whitepaper
        _labz.mint(escrowBeneficiary, _bd.fee);
        
        emit FeeTransactionEvent(escrowBeneficiary , _bd.fee);
      
       // lockedBalance[_sender] = toSender;
       // _lastBuyTime[_sender] = block.timestamp;
        emit NewVIPBuyerEvent(_bd.from, _bd.value, _bd.qty);
       
        _saleRefundEscrow.deposit(msg.sender);
      
    }

    
    function closeSale() public onlyOwner  {

        if(totalMinted < maxTokensForPrivateSale && block.timestamp > startTime + maxSaleDuration) {
            revert("cannot close sale yet");
        }

        privateSaleIsStarted = false;
        _saleRefundEscrow.close();
        isClosed = true;
    }

    function forceClose() public onlyOwner {
         privateSaleIsStarted = false;
      //  _saleRefundEscrow.close();
        isClosed = true;
    }

    function restart() public onlyOwner {
             privateSaleIsStarted = true;
      //  _saleRefundEscrow.close();
      startTime = block.timestamp;
        isClosed = false;
        breakIsOn = false;
    }

    function setPublicLaunchContract(address publicSale) public onlyOwner {
        require(isClosed == true && breakIsOn != true, "cannot set before private sale is completed");
        _labz.transferOwnership(publicSale); // token contract ownership is transfered to the public contract after the private sale
        _saleRefundEscrow.beneficiaryWithdraw();
    }

    // @notice only to be used in case of extreme emergency (ie: security breach, funds become unsafe after an attack) so holders can withdraw their funds.
    function emergencyBreakAndEnableRefunds() public onlyOwner nonReentrant {
            require(breakIsOn != true, "break already active");
            require(privateSaleIsStarted == true, "sale not started yet");
            breakIsOn = true;
            privateSaleIsStarted = false;
            _saleRefundEscrow.enableRefunds();
    }

    // @notice only to be used in case of medium to high level of emergency. Will not enable refunds. (IE: medium - high level, funds are still safe)
    function emergencyBreak() public onlyOwner nonReentrant {
        require(breakIsOn != true, "break already active");
        require(privateSaleIsStarted == true, "sale not started yet");
        breakIsOn = true;
        privateSaleIsStarted = false;
    }

    receive() external payable {
        if(msg.sender.isContract() == true) {
            revert("only real people can buy from the private sale!");
        }
    }


}