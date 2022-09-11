// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IBank {

    enum OperationType {
        DEPOSIT,
        WITHDRAW,
        OPEN_ACCOUNT,
        CLOSE_ACCOUNT,
        STAKE,
        UNSTAKE,
        PLEDGE,
        UNPLEDGE,
        CLAIM,
        MOVE_MONEY,
        PAYMENT,
        SAFETY_DEPOSIT,
        FEE
    }

    event NewBank(address indexed operator, address[] indexed founders, address indexed bankAddress);
    event NewFounder(address indexed operator, address indexed founder, uint256 allocation, uint256 lockedUntil);
    event LogOperationEvent(address indexed from, address indexed to, OperationType oType, bytes32 _identifier, uint256 _value);
    event LogFeeEvent(address indexed from, address indexed to, uint256 _feeValue);



    function OpenBank() external;
    function PauseBank() external;
    function registerFounder(address founder, uint256 allocation) external;
    function deRegisterFounder(address founder) external;
    function OpType(string memory opType) external returns(OperationType);
    function sendToMultisignatureVault(address multi) external returns(bool);
    function setMultisignatureWallet(address multi) external returns(bool);
    function getAccountInfo(address from) external returns(bytes calldata);

}