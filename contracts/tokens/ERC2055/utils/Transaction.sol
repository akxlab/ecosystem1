// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

abstract contract AKXTransaction {

    enum Operation {Call, DelegateCall}

    struct Nonce {
        uint256 _value;
    }

    Nonce public nonce;

    struct ERC2055Tx {
        address to;
        uint256 value;
        bytes data;
        Operation operation;
        uint256 safeTxGas;
        uint256 baseGas;
        uint256 gasPrice;
        address gasToken;
        address refundReceiver;
        uint256 _nonce;
    }

    bytes32 private constant ERC2055_TX_TYPEHASH = keccak256("akxTx(address to,uint256 value,bytes data,uint8 operation,uint256 safeTxGas,uint256 baseGas,uint256 gasPrice,address gasToken,address refundReceiver,uint256 nonce)");
    bytes32 private constant DOMAIN_SEPARATOR_TYPEHASH = keccak256("uint256 chainId,address verifyingContract");

    fallback() external {}

    function domainSeparator() public view returns (bytes32) {
        return keccak256(abi.encode(DOMAIN_SEPARATOR_TYPEHASH, getChainId(), this));
    }

    function encodeTxData(ERC2055Tx data) public view returns (bytes memory) {
        bytes32 erc2055TxHash = keccak256(
        abi.encode(
        ERC2055_TX_TYPEHASH,
        data.to,
        data.value,
        keccak256(data.data),
        data.operation,
        data.safeTxGas,
        data.gasPrice,
        data.gasToken,
        data.refundReceiver,
        data._nonce
            )
        );

        return abi.encodePacked(bytes1(0x19), bytes1(0x01), domainSeparator(), erc2055TxHash);
    }

    function currentNonce() internal returns(uint256) {
        _nonce = nonce._value;
        return _nonce;
    }

    function incrementNonce() internal {
        nonce = Nonce(currentNonce() + 1);
    }

    /// @dev Returns the chain id used by this contract.
    function getChainId() public view returns (uint256) {
        uint256 id;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            id := chainid()
        }
        return id;
    }


}