// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "../tokens/ERC2055/ERC2055.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";

import "@openzeppelin/contracts-upgradeable/utils/introspection/ERC165Upgradeable.sol";
import "../utils/Pricing.sol";
import "../utils/LibMath.sol";
import "../tokens/ERC2055/utils/BuyingLogic.sol";


import "../utils/DAOUtils.sol";

bytes4 constant BUY_VIP_ID = 0x077e403e;
bytes4 constant CURRENT_PRICE_ID = 0x9d1b464a;
bytes4 constant NORMAL_BUY_ID = 0xa6f2ae3a;
bytes4 constant AVAIL_BALANCE_ID = 0xa0821be3;

contract LabzERC2055 is
  Initializable,
    ERC2055,
    ReentrancyGuardUpgradeable,
    BuyingLogic
{
    address public multiSignatureWallet;
    bool internal canSell;
    bool internal canBuy;
    bool public vipSale;
    uint256 public vipSupply;
    uint256 public lockDuration;
    mapping(address => uint256) internal _lastBuyTime;
    mapping(address => bool) internal _vipHolders;
    mapping(address => bool) internal _isUnlocked;
    mapping(address => uint256) public lockedBalance;

    event NewVIPBuyerEvent(
        address indexed buyer,
        uint256 matics,
        uint256 labzQty
    );
    event FeeTransactionEvent(address indexed to, uint256 labzQty);

    constructor() ERC2055("AKX3 LABZ TOKEN", "LABZ") {
        _disableInitializers();
    }

    function initialize(address _gnosisMulti, address uds) public initializer {
        init(address(this), _gnosisMulti, uds);
        setMaxSupply(3000000000 * 1e18); // max supply NOT PREMINTED
        setPrice(BASE_PRICE_MATIC, 80001);
        multiSignatureWallet = _gnosisMulti;

        vipSupply = 6000000 * 1e18;
        lockDuration = 90 days;
        canBuy = false;
        vipSale = true;
        setSaleType("PRIVATE");
        setMinter(address(this));
    }

    function getChainID() internal view returns (uint256) {
        uint256 id;
        assembly {
            id := chainid()
        }
        return id;
    }

    function currentPrice() public view returns (uint256) {
        return getPrice(80001);
    }

    function buy()
        external
        payable
        override
        nonReentrant
        returns (bool success)
    {
        require(canBuy == true, "LABZ: cannot buy yet");
        uint256 _val = msg.value;
        address _sender = msg.sender;
        require(
            _sender != address(0),
            "LABZ: transfer _sender the zero address"
        );
        uint256 qty = calculateTokenQty(_val);
        uint256 fee = calculateFee(qty * 1e18) * 1e18;
        uint256 toSender = (qty * 1e18) - fee;
        uint256 toMulti = fee;
        safeMint(_sender, toSender);
        safeMint(multiSignatureWallet, toMulti);
        success = true;
    }

    function transfer(address to, uint256 amount)
        public
        override
        nonReentrant
        returns (bool)
    {
        if (
            verifySellPermissions(msg.sender, amount) != true &&
            to != multiSignatureWallet
        ) {
            revert("LABZ: cannot transfer yet");
        }
        return safeTransferToken(address(this), to, amount);
    }

    /** VIP SALE FUNCTIONS **/

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

    function verifySellPermissions(address _sender, uint256 amount)
        internal
        returns (bool)
    {
        // @notice vip holders funds are locked for 90 days from the time of the last buy they made as stated in the whitepaper
        // @notice this only affects purchase made during the vip sale
        if (
            _vipHolders[_sender] == true &&
            canSell == true &&
            _lastBuyTime[_sender] + lockDuration > block.timestamp + 25 seconds
        ) {
            lockedBalance[_sender] = 0;
            _isUnlocked[_sender] = true;
            return true;
        } else if (!isHavingAvailableBalance(_sender)) {
            return false;
        } else if (amount > availableBalance(_sender)) {
            return false;
        } else if (_isUnlocked[_sender] == true) {
            return true;
        } else {
            return canSell;
        }
    }

    function availableBalance(address _sender) public view returns (uint256) {
        uint256 _locked = lockedBalance[_sender];
        uint256 bal = balanceOf(_sender);
        return bal - _locked;
    }

    function isHavingAvailableBalance(address _sender)
        public
        view
        returns (bool)
    {
        return availableBalance(_sender) > 0;
    }

    receive() external payable {}

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        returns (bool)
    {
        return (interfaceId == BUY_VIP_ID ||
            interfaceId == CURRENT_PRICE_ID ||
            interfaceId == NORMAL_BUY_ID ||
            interfaceId == AVAIL_BALANCE_ID ||
            interfaceId == type(IERC165).interfaceId);
    }

   
}