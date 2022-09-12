// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./AkxWallet.sol";


contract AkxWalletManager {


    bytes4 internal constant EIP1271_MAGIC_VALUE = 0x20c13b0b;
    bytes4 internal constant UPDATED_MAGIC_VALUE = 0x1626ba7e;

    address internal singleton;
    mapping(address => address) internal modules;
    mapping(address => address) internal owners;
    uint256 internal nonce;
    mapping(bytes32 => uint256) internal signedMessages;
    mapping(address => mapping(bytes32 => uint256)) internal approvedHashes;


    bytes32 private constant AKX_MSG_TYPEHASH = keccak256("akxMessage(bytes message)");


    function isValidSignature(bytes memory _data, bytes memory _signature) public view virtual  returns (bytes4) {
        // Caller should be an AkxWallet
        AkxWallet wallet = AkxWallet(payable(msg.sender));
        bytes32 messageHash = getMessageHashForWallet(wallet, _data);
        if (_signature.length == 0) {
            require(wallet._signedMessages(messageHash) != 0, "Hash not approved");
        } else {
            wallet.checkSignature(messageHash, _data, _signature);
        }
        return EIP1271_MAGIC_VALUE;
    }

    /**
    * Implementation of updated EIP-1271
    * @dev Should return whether the signature provided is valid for the provided data.
     *       The save does not implement the interface since `checkSignatures` is not a view method.
     *       The method will not perform any state changes (see parameters of `checkSignatures`)
     * @param _dataHash Hash of the data signed on the behalf of address(msg.sender)
     * @param _signature Signature byte array associated with _dataHash
     * @return a bool upon valid or invalid signature with corresponding _dataHash
     * @notice See https://github.com/gnosis/util-contracts/blob/bb5fe5fb5df6d8400998094fb1b32a178a47c3a1/contracts/StorageAccessible.sol
     */
    function isValidSignature(bytes32 _dataHash, bytes calldata _signature) external view  returns (bytes4) {
        ISignatureValidator validator = ISignatureValidator(msg.sender);
        bytes4 value = validator.isValidSignature(abi.encode(_dataHash), _signature);
        return (value == EIP1271_MAGIC_VALUE) ? UPDATED_MAGIC_VALUE : bytes4(0);
    }

    function getMessageHash(bytes memory message) public view virtual  returns (bytes32) {
        return getMessageHashForWallet(AkxWallet(payable(msg.sender)), message);
    }

    function getMessageHashForWallet(AkxWallet wallet, bytes memory message) public view virtual  returns (bytes32) {
        bytes32 walletMessageHash = keccak256(abi.encode(AKX_MSG_TYPEHASH, keccak256(message)));
        return keccak256(abi.encodePacked(bytes1(0x19), bytes1(0x01), wallet.domainSeparator(), walletMessageHash));
    }

}