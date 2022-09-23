// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


import "./AKXSetup.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlEnumerableUpgradeable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "./Roles.sol";

contract AKXSystem is Initializable, UUPSUpgradeable, AKXSetup, AKXRoles, AccessControlEnumerableUpgradeable {

    string public name;
    bool internal _setup;

    address public safe;

    using SafeERC20 for IERC20;

    mapping(address => bool) public checkFounder;
    mapping(address => uint256) public founderAllocations;

    struct InternalStorage {
        string version;
        uint256 systemStartDate;
        uint256 numHolders;
        uint8 privateSale;
    }

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function _authorizeUpgrade(address newImplementation)
    internal
    onlyRole(UPGRADER_ROLE)
    override
    {}

    function initialize(string memory version_, string memory name_, address safe_) initializer public {
        __Context_init();
        __AccessControl_init();
        __UUPSUpgradeable_init();

        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(UPGRADER_ROLE, msg.sender);
        _grantRole(AKX_OPERATOR_ROLE, msg.sender);
        InternalStorage storage s = AKXStorage();
        s.systemStartDate = block.timestamp;
        s.numHolders = 0;
        name = name_;
        _setup = false;
        safe = safe_;
    }

    function updateVersion(string memory version_) public onlyRole(UPGRADER_ROLE) {
        InternalStorage storage s = AKXStorage();
        s.version = version_;
    }

    function version() public  returns (string memory ver) {
        InternalStorage storage s = AKXStorage();
        ver = s.version;
    }

    function holdersCount() public returns (uint256) {
        InternalStorage storage s = AKXStorage();
        return s.numHolders;
    }

    function isPrivateSale() public  returns (bool) {
        InternalStorage storage s = AKXStorage();
        return s.privateSale == 0x1;
    }

    function sysStartDate() public  returns (uint256) {
        InternalStorage storage s = AKXStorage();
        return s.systemStartDate;
    }

    function AKXStorage() internal returns (InternalStorage storage s) {
        bytes32 AKX_STORAGE_ID = keccak256("akx3.ecosystem.storage");
        assembly {
            s.slot := AKX_STORAGE_ID
        }
    }

    function startPrivateSale() public onlyRole(UPGRADER_ROLE) {
        InternalStorage storage s = AKXStorage();
        s.privateSale = 0x1;
        // we start the private sale
    }

    function stopPrivateSale() public onlyRole(UPGRADER_ROLE) {
        InternalStorage storage s = AKXStorage();
        s.privateSale = 0x0;
        // we stop the private sale
    }

    function systemSetup(address labzToken_,
        address userDataService_,
        address dexService_,
        address daoGovernor_,
        address akxToken_, // vote enabled token
        address refContract_,
        address psl_,
        address rootController_) public onlyRole(UPGRADER_ROLE) {
        require(_setup != true, "cannot setup");
        _setLabzToken(labzToken_);
        _setUDS(userDataService_);
        _setRootController(rootController_);
        _setAkxToken(akxToken_);
        _setDEX(dexService_);
        _setPrivateSaleLogic(psl_);
        _setReferralContract(refContract_);
        _setGov(daoGovernor_);
    }

    function Labz() public returns(address) {
        return labzToken;
    }

    function Uds() public returns(address) {
        return userDataService;
    }

    function Akx() public returns(address) {
        return akxToken;
    }

    function Referrals() public returns(address) {
        return refContract;
    }

    function PrivateSale() public returns(address) {
        return psl;
    }

    function RootController() public returns(address) {
        return rootController;
    }

    function Governor() public returns(address) {
        return daoGovernor;
    }

    function DEX() public returns(address) {
        return dexService;
    }

    function addFounder(address _founder, uint256 allocation, address founderToken) public onlyRole(AKX_OPERATOR_ROLE) {
        require(checkFounder[_founder] != true, "founder already exists");
        require(_founder != address(0), "zero address");
        IERC20(founderToken).safeTransfer(_founder, allocation);
        checkFounder[_founder] = true;
        founderAllocations[_founder] = allocation;
    }


}