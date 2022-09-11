// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

bytes32 constant BRIDGE_TX_TYPE_ID = bytes4(keccak256(abi.encodePacked('TxTypeID()')));
bytes32 constant BRIDGE_MSG_TYPE_ID = bytes4(keccak256(abi.encodePacked('BridgeMsg(bytes message)')));

enum Operation {Call, DelegateCall}

struct BridgeTransaction {
    uint256 chainId;
    address to;
        uint256 value;
        bytes data;
        Operation operation;
        uint256 bridgeTxGas;
        uint256 baseGas;
        uint256 gasPrice;
        address gasToken;
        address refundReceiver;
        address bridgeReceiver;
        uint256 _nonce;
}

interface IBridgeTransaction {
    event SendBridgeCurrencyTransaction(address from, uint256 chainId, address target, bytes message, uint256 fees, uint256 amount);
    event BridgeSignedMessage(bytes32 indexed msgHash);
    function signMessage(bytes calldata _data) external;
    function getMessageHash(bytes memory message) external view returns (bytes32);
}

interface IRootBridgeObserver {

    event ReceivedBridgeEvent(address _from, uint256 chainId, address target, bytes message);
    event TransferBridgeEvent(address _to, uint256 chainId, address target, bytes message);
   

}