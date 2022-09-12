// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "../modules/uds/UserDataServiceResolver.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "./Pricing.sol";
import "./LibMath.sol";
import {IERC2055} from "./LabzERC2055.sol";

    struct AccountInfo {
        uint256 tokenId;
        bytes32 identity;
        address owner;
        bytes32 metasId;
        uint256 timestamp;
    }

contract BuyingLogic is ReentrancyGuard, Pricing, LibMath {

    event BuyingLogic(address indexed _buyer, uint256 amountSent, bool vip);
    event AccountCreated(address indexed _buyer, uint256 _accountNumber);
    event LoadingAccount(uint256 _accountNumber);
    event AccountLoaded(uint256 _accountNumber);



    mapping(address => bool) internal _hasAccount;
    mapping(address => uint256) internal _userTokens;
    mapping(address => AccountInfo) private _loadedAccounts;
    mapping(address => bool) private _isLoaded;

    // @dev this buying logic contract will only work for IERC2055 tokens (AKX secure fungible token type)
    IERC2055 private _token;

    UserDataServiceResolver _uds;

    constructor(address _erc2055Token) {
        _token = IERC2055(_erc2055Token);
    }

    /**
    * @dev _beforeLogic internal function that loads the account of the sender if any if there is none, it creates one and loads it
    * @notice hook called before starting the actual buying logic
    * @params address _sender
    * @returns bool done will return true if loaded with success, false otherwise
    */

    function _beforeLogic(address _sender) internal returns(bool done) {

        // @dev if the sender is not having an account yet (USER ERC721) create one

        if(_hasAccount[_sender] == false) {
            uint256 ___id = _uds.createNewAccount(_sender, "");
            _hasAccount[_sender] = true;
            _userTokens[_sender] = ___id;
            emit NewAccountCreated(_sender, ___id);
        } else {

        // @dev else load the token id associated with the sender address

            uint256 ___id =  _userTokens[_sender];
        }


        // @dev if sender info is not loaded yet, load them

        if(_isLoaded[_sender] != true) {

        // @dev event we will listen to in the frontend to know when loading starts (spinner starts)

        emit LoadingAccount(___id);
        _loadedAccounts[_sender] = _uds.getAccountInfo(_sender);
            _isLoaded[_sender] = true;
        }

        // @dev event we will listen to in the frontend to know when loading ends (spinner stops)

        emit AccountLoaded(___id);
        done = true;
    }

    function _startLogic(address _sender, uint256 _amountSent, bool isVip) internal {
        require(_beforeLogic(_sender), "akx3/buying_logic/beforeLogic_hook_undefined");
        emit BuyingLogic(_sender, _amountSent, isVip);
        if(isVip == true) {
            _addMetasToNFT(_userTokens[_sender], "VIP", abi.encode(1));
        }
    }


    //function setMetaData(uint256 tokenId, string memory keyStr, uint _dtype, bytes memory value, bool editable, bool encrypted) external
    function _addMetasToNFT(uint256 _tid, string memory key, bytes memory value) internal {
        _uds.setMetaData(_tid, key,  0, value, false, false);
    }

    function buyVip() external payable nonReentrant {
        if (vipSale != true) {
            revert("LABZ: vip sale is over");
        }
        uint256 _val = msg.value;
        address _sender = msg.sender;
        if (_totalSupply == vipSupply) {
            closeSale();
        }
        uint256 qty = calculateTokenQty(_val);
        uint256 fee = calculateFee(qty);
        uint256 toSender = qty - fee;
        /*
        @notice 10% of the transaction is sent to the gnosis multisignature wallet for the reserve as stated in the Whitepaper
        */
        uint256 toMulti = fee;
        safeMint(_sender, toSender);
        safeMint(multiSignatureWallet, toMulti);
        emit FeeTransactionEvent(multiSignatureWallet, toMulti);
        lockedBalance[_sender] = toSender;
        _lastBuyTime[_sender] = block.timestamp;
        emit NewVIPBuyerEvent(_sender, _val, qty);
    }

    function closeSale() internal {
        vipSale = false; // we close the sale
        canBuy = true; // people can now buy publicly
        canSell = true; // people can sell when their funds are unlocked
    }

}