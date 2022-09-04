// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "../tokens/ERC2055/ERC2055.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "./Pricing.sol";
import "./LibMath.sol";

contract LabzERC2055 is ERC2055, Pricing, ReentrancyGuard  {

    address public multiSignatureWallet;
    bool internal canSell;
    bool internal canBuy;
    bool internal vipSale;
    uint256 internal vipSupply;
    uint256 public lockDuration;
    mapping(address => uint256) internal _lastBuyTime;
    mapping(address => bool) internal _vipHolders;
    mapping(address => bool) internal _isUnlocked;
    mapping(address => uint256) public lockedBalance;

    constructor(address userRegistry, address _gnosisMulti) ERC2055("LABZ (AKX3 ECOSYSTEM)", "LABZ") {
        setTotalSupply(0);
        setMaxSupply(300000000000 * 1e18);
        multiSignatureWallet = _gnosisMulti;
        if(block.chainid == 137 || block.chainid == 80001) {
        setPrice(BASE_PRICE_MATIC, getChainID());
        }
        vipSupply = 6000000000 * 1e18;
        lockDuration = 90 days;
        canBuy = false;
        vipSale = true;
    }

    function getChainID() internal view returns (uint256) {
        uint256 id;
        assembly {
            id := chainid()
        }
        return id;
    }

    function currentPrice() public  returns(uint256) {
        return getPrice(block.chainid);
    }

    function buy() external nonReentrant payable {
        require(canBuy == true, "LABZ: cannot buy yet");
        uint256 _val = msg.value;
        address _sender = msg.sender;
        require(_sender != address(0), "LABZ: transfer _sender the zero address");
        uint256 qty = LibMath.calculateTokenQty(_val);
        uint256 fee = LibMath.calculateFee(qty * 1e18) * 1e18;
        uint256 toSender = (qty * 1e18) - fee;
        uint256 toMulti = fee;
        safeMint(toSender, _sender);
        safeMint(toMulti, multiSignatureWallet);
    }

    function transfer(address to, uint256 amount) public override nonReentrant returns(bool) {
        if(verifySellPermissions(msg.sender, amount) != true && to != multiSignatureWallet) {
        revert("LABZ: cannot transfer yet");
        }
        return safeTransferToken(address(this), to, amount);
    }

    /** VIP SALE FUNCTIONS **/

    function buyVip(address _sender, uint256 _val) external nonReentrant {
        if(vipSale != true) {
            revert("LABZ: vip sale is over");
        }
        if(totalSupply() == vipSupply) {
            closeSale();
        }
        uint256 qty = LibMath.calculateTokenQty(_val);
        uint256 fee = LibMath.calculateFee(qty * 1e18) * 1e18;
        uint256 toSender = (qty * 1e18) - fee;
        /*
        @notice 10% of the transaction is sent to the gnosis multisignature wallet for the reserve as stated in the Whitepaper
        */
        uint256 toMulti = fee;
        safeMint(toSender, _sender);
        safeMint(toMulti, multiSignatureWallet);
        lockedBalance[_sender] = toSender;
        _lastBuyTime[_sender] = block.timestamp;
    }

    function closeSale() internal {
        vipSale = false; // we close the sale
        canBuy = true; // people can now buy publicly
        canSell = true; // people can sell when their funds are unlocked
    }

    function verifySellPermissions(address _sender, uint256 amount) internal returns(bool) {
        // @notice vip holders funds are locked for 90 days from the time of the last buy they made as stated in the whitepaper
        // @notice this only affects purchase made during the vip sale
        if(_vipHolders[_sender] == true && canSell == true && _lastBuyTime[_sender] + lockDuration > block.timestamp + 25 seconds) {
            lockedBalance[_sender] = 0;
            _isUnlocked[_sender] = true;
        return true;
        } else if(!isHavingAvailableBalance(_sender)) {
            return false;
        } else if(amount > availableBalance(_sender)) {
            return false;
        } else if(_isUnlocked[_sender] == true) {
            return true;
        } else  {
            return canSell;
        }

    }

    function availableBalance(address _sender) public view returns(uint256) {
        uint256 _locked = lockedBalance[_sender];
        uint256 bal = balanceOf(_sender);
        return bal - _locked;
    }

    function isHavingAvailableBalance(address _sender) public view returns(bool) {
        return availableBalance(_sender) > 0;
    }

    receive() external payable {}


}