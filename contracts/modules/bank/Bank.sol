// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "./IBank.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "../uds/UserDataServiceResolver.sol";

import "@openzeppelin/contracts/proxy/Clones.sol";
import "./Account.sol";

bytes32 constant OPERATOR_ROLE = keccak256(abi.encodePacked("OPERATOR_ROLE"));

contract Bank is IBank, Context,  Pausable, AccessControlEnumerable {

    mapping(string => OperationType) private _opStrings;
    mapping(string => bool) private _opExists;
    mapping(string => bool) private _allowedOps;
    mapping(address => bool) private _founders;
    mapping(address => bytes32) private _nonces;
    mapping(address => mapping(address => uint256)) private _balances; // token address => wallet address => balance
    enum AccountType {
        GENERAL,
        PRESALE,
        VIP,
        FOUNDER,
        INTERNAL,
        INTERESTS,
        RESERVE,
        ADVISORS,
        DEV_WALLET,
        BANNED
    }

    mapping(string => AccountType) private _accountTypes;
    mapping(string => mapping(uint => address)) private _addressesByType;

    address private __multi;
    address private __userDataService;
    using SafeERC20 for IERC20;

    address private __accountImpl;

    uint256 private __numAccounts;


    constructor(string memory uri_, address accImpl) {
        __accountImpl = accImpl;
        __numAccounts = 0;
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
        _setupRole(OPERATOR_ROLE, _msgSender());
    }

    function OpenBank() external {
        require(hasRole(OPERATOR_ROLE, _msgSender()), "ERC1155 BANK: must have pauser role to unpause");
        _unpause();
    }
    function PauseBank() external {
        require(hasRole(OPERATOR_ROLE, _msgSender()), "ERC1155 BANK: must have pauser role to pause");
        _pause();
    }
    function registerFounder(address founder, uint256 allocation) external {}
    function deRegisterFounder(address founder) external {}
    function OpType(string memory opType) external returns(OperationType) {
        require(_opExists[opType], "ERC1155 BANKOP: operation not found");
        return _opStrings[opType];
    }
    function sendToMultisignatureVault(address multi) external returns(bool) {
        require(hasRole(OPERATOR_ROLE, _msgSender()), "ERC1155 BANK: must have pauser role to send to the vault wallet");
        uint256 nativeCurrencyBalance = (address(this)).balance;
        if(nativeCurrencyBalance <= 0) {
            revert("NO_BALANCE");
        }
        payable(multi).transfer(nativeCurrencyBalance);
        return true;

    }
    function setMultisignatureWallet(address multi) external returns(bool) {
        require(hasRole(OPERATOR_ROLE, _msgSender()), "ERC1155 BANK: must have pauser role to set wallet");
        __multi = multi;
        return true;
    }

    function setUserDataService(address _udsr) external returns(bool) {
        require(hasRole(OPERATOR_ROLE, _msgSender()), "ERC1155 BANK: must have pauser role to set data service");
        __userDataService = _udsr;
        return true;
    }
    function getAccountInfo(address from) external returns(bytes memory) {
        bytes memory aInfo = abi.encode(UserDataServiceResolver(__userDataService).getAccountInfo(from));
        return aInfo;
    }

    function createNewAccount(address _for, string memory _aType, bytes memory keyParts) public returns(address) {
        require(hasRole(OPERATOR_ROLE, _msgSender()), "ERC1155 BANK: must have operator role to create accounts");
        bytes32 nonce = keccak256(abi.encodePacked(_for, _aType));
        _nonces[_for] = nonce;
        address newAccount = Clones.cloneDeterministic(__accountImpl, nonce);

        _addressesByType[_aType][__numAccounts] = newAccount;
        Account(newAccount).initialize(_for, _aType, keyParts);

        __numAccounts += 1;
        return newAccount;
    }

    function getAccountAddress(address _for) public returns(address) {
        return Clones.predictDeterministicAddress(__accountImpl, _nonces[_for]);
    }



}