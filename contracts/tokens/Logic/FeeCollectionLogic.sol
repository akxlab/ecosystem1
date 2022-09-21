// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;


import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
contract FeeCollectionLogic is Ownable {

    address payable public feeEscrow;
    ERC20 internal feeToken;

    using SafeERC20 for ERC20;

    enum FeeTypes {
        DEFAULT,
        TX_FEE,
        TX_PREMIUM,
        DAO,
        DEX
    }

    struct TxAmounts {
        uint256 amountIn;
        uint256 amountOut;
    }

    struct FeeDetails {
        FeeTypes feeType;
        TxAmounts txIO;
        uint256 fee;
    }

    mapping(address => mapping(uint256 => FeeDetails))  private _feesByAddress;
    mapping(address => uint256) private _indexes;
    mapping(address => uint256) private _totalFeePaid;

    mapping(bytes32 => uint128) private _feeTypes;
  

    uint128 public constant Mantissa = 1e6;
    uint128 public constant PercentDefault = 150000; // 1.5% or 0.015 * Mantissa default tx fee on public sale
    uint128 public constant PercentPerPledge = 10 * Mantissa;  // 10% goes for overheads in private sale pledges
    uint128 public constant FeeRedistributionPercent = 60 * Mantissa; // 60% of fees are redistributed to holders
    

    bytes32 private constant DEFAULT_FEE = keccak256("DEFAULT_FEE");
    bytes32 private constant TX_FEE = keccak256("TX_FEE");
    bytes32 private constant TX_PREMIUM = keccak256("TX_PREMIUM");
    bytes32 private constant DAO_FEE = keccak256("DAO_FEE");
    bytes32 private constant DEX_FEE = keccak256("DEX_FEE");

    event FeeCollected(address indexed from, address indexed to, uint256 origAmt, uint256 feeAmt);

    constructor(address payable __feeToken, address payable _feeEscrow) {
        feeToken = ERC20(__feeToken);
        feeEscrow = _feeEscrow;
        _feeTypes[DEFAULT_FEE] = PercentDefault;
        _feeTypes[TX_FEE] = PercentDefault;
        _feeTypes[TX_PREMIUM] = PercentPerPledge;
        _feeTypes[DAO_FEE] = 0; // not active yet
        _feeTypes[DEX_FEE] = 0; // not active yet
    }

    function GetFee(bytes32 feeType, uint256 amount) public onlyOwner returns(uint256) {
        
        uint128 feePercent = _feeTypes[feeType];
        uint128 amt = uint128(amount);
        uint128 fee = uint128(_calculateFee(amt, feePercent));
        return uint256(fee);

    }

    function Collect(FeeTypes feeType, uint256 amount, uint256 amountWithFee, uint256 _fee, address _sender) public onlyOwner {
        _indexes[_sender] += 1;
        FeeDetails memory _fd = FeeDetails(feeType, TxAmounts(amount, amountWithFee), _fee);
        _feesByAddress[_sender][_indexes[_sender]] = _fd;
        _totalFeePaid[_sender] += _fee;
        feeToken.safeTransferFrom(_sender, feeEscrow, _fee);
        emit FeeCollected(_sender, feeEscrow, amount, _fee);
    }

    function _calculateFee(uint128 _amt, uint128 _percent) internal returns(uint) {
        return _amt * _percent / Mantissa;
    }




}