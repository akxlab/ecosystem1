// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "../interfaces/IRootBridge.sol";
import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";
import "@openzeppelin/contracts/utils/Context.sol";

bytes4 constant SET_CHILD_BRIDGE_ID = 0x79331922;
bytes4 constant SET_ROOT_BRIDGE_OBSV_ID = 0x1eb5de0c;
bytes4 constant SET_ROOT_BRIDGE_ID = 0x7a9726ac;
bytes4 constant SET_NONEVM_BRIDGE_ID = 0x40f7f16a;
bytes4 constant SIGN_MESSAGE_ID = 0x85a5affe;
bytes4 constant GET_MSG_HASH_ID = 0x0a1028c4;

contract Bridge is
    Context,
    IRouteBridge,
    AccessControlEnumerable,
    IRootBridgeObserver,
    IBridgeTransaction
{

    bytes4 private constant INTERFACE_IDS = 
        bytes4(SET_CHILD_BRIDGE_ID | SET_ROOT_BRIDGE_OBSV_ID | SET_ROOT_BRIDGE_ID
        | SET_NONEVM_BRIDGE_ID | SIGN_MESSAGE_ID | GET_MSG_HASH_ID);

    bytes32 private constant BRIDGE_OPERATOR_ROLE =
        keccak256(abi.encodePacked("BRIDGE_OPERATOR_ROLE"));

    address private _rootBridgeObserver;

    constructor(address bridgeOperator) {
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
        _setupRole(BRIDGE_OPERATOR_ROLE, bridgeOperator);
    }

    function setRootBridgeObserver(address _observer) external override {
        require(
            hasRole(BRIDGE_OPERATOR_ROLE, _msgSender()),
            "need operator role to set observer"
        );
        _rootBridgeObserver = _observer;
    }

    function setRootBridge(uint256 chainId, address rootBridge) external override {}

    function setChildBridge(uint256 chainId, address childBridge) external override {}

    function setNonEVMChildBridge(
        NonEVMChilds nonEvmBridgeID,
        uint256 txTemplateId
    ) external override {}

    function signMessage(bytes calldata _data) external override {}

    function getMessageHash(bytes memory message)
        external
        view
        override
        returns (bytes32)
    {}

    function supportsInterface(bytes4 interfaceID) public view override returns(bool) {
        return interfaceID == INTERFACE_IDS || super.supportsInterface(interfaceID);
    }

    receive() external payable {
        revert();
    }
    fallback() external payable {
        emit ReceivedBridgeEvent(msg.sender, block.chainid, address(this),_msgData());
    }
}