// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "../LabzERC20.sol";
import "../../utils/Pricing.sol";
import "../../utils/LibMath.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "../../modules/uds/UserDataServiceResolver.sol";


enum SALE_TYPE {
    NONE,
    PRIVATE,
    PUBLIC
}

abstract contract PrivateBuyingLogic is Pricing, LibMath, ReentrancyGuard {

    event BuyingLogicEvent(address indexed _buyer, uint256 amountSent, bool vip);
    event AccountCreated(address indexed _buyer, uint256 _accountNumber);
    event LoadingAccount(uint256 _accountNumber);
    event AccountLoaded(uint256 _accountNumber);
    event FeeTransactionEvent(address indexed recipient, uint256 amount);
    event  NewVIPBuyerEvent(address indexed from, uint256 amount, uint256 labz);



    mapping(address => bool) internal _hasAccount;
    mapping(address => uint256) internal _userTokens;
    mapping(address => bytes) private _loadedAccounts;
    mapping(address => bool) private _isLoaded;


    UserDataServiceResolver _uds;
    

    function _beforeLogic(address _sender) internal returns(bool done) {

        // @dev if the sender is not having an account yet (USER ERC721) create one
        uint256 ___id;

        if(_hasAccount[_sender] == false) {
             ___id = _uds.createNewAccount(_sender, "");
            _hasAccount[_sender] = true;
            _userTokens[_sender] = ___id;
           // emit NewAccountCreated(_sender, ___id);
        } else {

        // @dev else load the token id associated with the sender address

             ___id =  _userTokens[_sender];
        }


        // @dev if sender info is not loaded yet, load them

        if(_isLoaded[_sender] != true) {

        // @dev event we will listen to in the frontend to know when loading starts (spinner starts)

        emit LoadingAccount(___id);
        _loadedAccounts[_sender] = abi.encode(_uds.getAccountInfo(_sender));
            _isLoaded[_sender] = true;
        }

        // @dev event we will listen to in the frontend to know when loading ends (spinner stops)

        emit AccountLoaded(___id);

        done = true;
    }

    function _startLogic(address _sender, uint256 _amountSent, bool isVip) internal {
        require(_beforeLogic(_sender), "akx3/buying_logic/beforeLogic_hook_undefined");
        emit BuyingLogicEvent(_sender, _amountSent, isVip);
        if(isVip == true) {
            _uds.setNewMetaDatas(_userTokens[_sender], _sender);
            _addMetasToNFT(_sender, _userTokens[_sender], "VIP", abi.encode(1));
        }
    }


    //function setMetaData(uint256 tokenId, string memory keyStr, uint _dtype, bytes memory value, bool editable, bool encrypted) external
    function _addMetasToNFT(address _for, uint256 _tid, string memory key, bytes memory value) internal {
        _uds.setMetaData(_for, _tid, key,  0, value, false, false);
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