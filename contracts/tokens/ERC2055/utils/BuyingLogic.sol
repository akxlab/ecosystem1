// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import {IERC2055} from "../ERC2055.sol";
import "../../../utils/LibMath.sol";
import "../../../utils/Pricing.sol";
import "../../../modules/uds/UserDataServiceResolver.sol";
import "../../../modules/wallet/Factory.sol";

    struct AccountInfo {
        uint256 tokenId;
        bytes32 identity;
        address owner;
        bytes32 metasId;
        uint256 timestamp;
    }



enum SALE_TYPE {
    NONE,
    PRIVATE,
    PUBLIC
}

abstract contract BuyingLogic is Pricing, LibMath {

    event BuyingLogic(address indexed _buyer, uint256 amountSent, bool vip);
    event AccountCreated(address indexed _buyer, uint256 _accountNumber);
    event LoadingAccount(uint256 _accountNumber);
    event AccountLoaded(uint256 _accountNumber);
    event SaleTypeUpdated(SALE_TYPE origin, SALE_TYPE sale_type);



    mapping(address => bool) internal _hasAccount;
    mapping(address => uint256) internal _userTokens;
    mapping(address => bytes) private _loadedAccounts;
    mapping(address => bool) private _isLoaded;
    mapping(address => address) private _akxWallets;

    address internal _walletFactory;
    address public feeWallet;

    // @dev this buying logic contract will only work for IERC2055 tokens (AKX secure fungible token type)
    ERC2055 private _token;

    UserDataServiceResolver _uds;
    SALE_TYPE _sale_type;

    function init(address _erc2055Token, address walletFactory, address _fw, address uds) internal {
        _token = ERC2055(_erc2055Token);
        _sale_type = SALE_TYPE.NONE;
        _walletFactory = walletFactory;
        feeWallet = _fw;
        _uds = UserDataServiceResolver(uds);
    }

    function setSaleType(string memory saleType) internal returns(bool){
        if(keccak256(abi.encodePacked(saleType)) == keccak256(abi.encodePacked('PRIVATE'))) {
            _sale_type = SALE_TYPE.PRIVATE;
            return true;
        } else  if(keccak256(abi.encodePacked(saleType)) == keccak256(abi.encodePacked('PUBLIC'))) {
            _sale_type = SALE_TYPE.PUBLIC;
            return true;
        }
        revert("invalid sale type");

    }



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

        address wallet = AKXWalletFactory(_walletFactory).createWallet(_sender, keccak256(abi.encodePacked(_sender)));
        _akxWallets[_sender] = wallet;

        done = true;
    }

    function _startLogic(address _sender, uint256 _amountSent, bool isVip) internal {
        require(_beforeLogic(_sender), "akx3/buying_logic/beforeLogic_hook_undefined");
        emit BuyingLogic(_sender, _amountSent, isVip);
        if(isVip == true) {
            _uds.setNewMetaDatas(_userTokens[_sender], _sender);
            _addMetasToNFT(_sender, _userTokens[_sender], "VIP", abi.encode(1));
        }
    }


    //function setMetaData(uint256 tokenId, string memory keyStr, uint _dtype, bytes memory value, bool editable, bool encrypted) external
    function _addMetasToNFT(address _for, uint256 _tid, string memory key, bytes memory value) internal {
        _uds.setMetaData(_for, _tid, key,  0, value, false, false);
    }

    function buyPrivateSale() public payable OnlyPrivate {

        _startLogic(msg.sender, msg.value, true);
        uint256 _val = msg.value;
        address _sender = msg.sender;
        address _to = _akxWallets[_sender];

        uint256 qty = calculateTokenQty(_val);
        uint256 fee = calculateFee(qty);
        uint256 toSender = qty - fee;
        _token.safeMint(_to, toSender);
        _token.safeMint(feeWallet, fee);

       /*if (_totalSupply == vipSupply) {
            closeSale();
        }
        uint256 qty = calculateTokenQty(_val);
        uint256 fee = calculateFee(qty);
        uint256 toSender = qty - fee;
        /*
        @notice 10% of the transaction is sent to the gnosis multisignature wallet for the reserve as stated in the Whitepaper
        */
        /*uint256 toMulti = fee;
        safeMint(_sender, toSender);
        safeMint(multiSignatureWallet, toMulti);
        emit FeeTransactionEvent(multiSignatureWallet, toMulti);
        lockedBalance[_sender] = toSender;
        _lastBuyTime[_sender] = block.timestamp;
        emit NewVIPBuyerEvent(_sender, _val, qty);*/
    }


    modifier OnlyPrivate() {
        require(_sale_type == SALE_TYPE.PRIVATE, "only allowed in private sale mode");
        _;
    }

    modifier OnlyPublic() {
        require(_sale_type == SALE_TYPE.PUBLIC, "only allowed in public sale mode");
        _;
    }
}