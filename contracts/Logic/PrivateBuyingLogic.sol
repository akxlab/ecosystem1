// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "../tokens/LabzERC20.sol";
import "../utils/Pricing.sol";
import "../utils/LibMath.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "../tokens/AKXAccounts.sol";


enum SALE_TYPE {
    NONE,
    PRIVATE,
    PUBLIC
}

abstract contract PrivateBuyingLogic is Pricing, LibMath, ReentrancyGuard {

    event BuyEvent(address indexed _buyer, uint256 amountSent, bool vip);
    event FeeTransactionEvent(address indexed recipient, uint256 amount);
    event  NewVIPBuyerEvent(address indexed from, uint256 amount, uint256 labz);


    function _beforeLogic(address _sender) internal returns(bool done) {

        done = true;
    }

    function _startLogic(address _sender, uint256 _amountSent, bool isVip) internal {
        require(_beforeLogic(_sender), "akx3/buying_logic/beforeLogic_hook_undefined");
        emit BuyEvent(_sender, _amountSent, isVip);
    }


    struct BuyDetails {
        address from;
        uint256 value;
        uint256 qty;
        uint256 fee;
    }

    function executeBuyLogic(address _sender, uint256 value) internal returns(BuyDetails memory) {

        _startLogic(_sender, value, true);
        uint256 _val = msg.value;
        address _sender = msg.sender;
        address _to = _sender;

        uint256 qty = calculateTokenQty(_val);
        uint256 fee = calculateFee(qty);
        uint256 toSender = qty;
        
        
        return BuyDetails(_sender, value, qty, fee);
    }


    
}