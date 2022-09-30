// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import {LabzERC20} from "../tokens/LabzERC20.sol";
import {Pricing} from "../utils/Pricing.sol";
import {LibMath} from "../utils/LibMath.sol";
import {ReentrancyGuard} from "@openzeppelin/contracts/security/ReentrancyGuard.sol";



enum SALE_TYPE {
    NONE,
    PRIVATE,
    PUBLIC
}

abstract contract PrivateBuyingLogic is Pricing, LibMath, ReentrancyGuard {

    event BuyEvent(address indexed _buyer, uint256 amountSent, bool vip);
    event FeeTransactionEvent(address indexed recipient, uint256 amount);
    event  NewVIPBuyerEvent(address indexed from, uint256 amount, uint256 labz);


   

    function _startLogic(address _sender, uint256 _amountSent, bool isVip) internal {

        emit BuyEvent(_sender, _amountSent, isVip);
    }


    struct BuyDetails {
        address from;
        uint256 value;
        uint256 qty;
        uint256 fee;
    }

    function executeBuyLogic(address sender_, uint256 value) internal returns(BuyDetails memory) {

        _startLogic(sender_, value, true);
        uint256 _val = msg.value;
        address _sender = msg.sender;
      

        uint256 qty = calculateTokenQty(_val);
        uint256 fee = calculateFee(qty);
       
        
        
        return BuyDetails(_sender, value, qty, fee);
    }


    
}