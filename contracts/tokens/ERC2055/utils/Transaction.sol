// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./ISignatureValidator.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "../../../utils/LibMath.sol";
abstract contract ERC2055Transaction is ISignatureValidatorConstants, LibMath {

    using SafeMath for uint256;

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

    mapping(address => mapping(bytes32 => uint256)) public approvedHashes;


    function domainSeparator() public view returns (bytes32) {
        return keccak256(abi.encode(DOMAIN_SEPARATOR_TYPEHASH, getChainId(), this));
    }

    function encodeTxData(ERC2055Tx memory data) public view returns (bytes memory) {
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

    function currentNonce() internal view returns(uint256) {
        uint256 _nonce = nonce._value;
        return nonce._value;
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

    function getTransactionHash(ERC2055Tx memory data) public view returns(bytes32) {
        return keccak256(encodeTxData(data));
    }

    function createERC2055Tx(
        address to,
        uint256 value,
        bytes calldata data,
        Operation operation,
        uint256 safeTxGas,
        uint256 baseGas,
        uint256 gasPrice,
        address gasToken,
        address refundReceiver,
uint256 _nonce
    ) public pure returns(ERC2055Tx memory _data) {
        _data = ERC2055Tx(to,value,data,operation,safeTxGas,baseGas, gasPrice, gasToken, refundReceiver, _nonce);
    }

    function checkSignature(bytes32 dataHash, bytes memory data, bytes memory signature) public view {
        address currentWallet;
        uint8 v;
        bytes32 r;
        bytes32 s;
        uint256 i;
    (v,r,s) = signatureSplit(signature, 0);
        if(v == 0) {
            currentWallet = address(uint160(uint256(r)));
            require(uint256(s) + 32 <= signature.length, "bad signature bytes");



            // Check if the contract signature is in bounds: start of data is s + 32 and end is start + signature length
            uint256 contractSignatureLen;
            // solhint-disable-next-line no-inline-assembly
            assembly {
                contractSignatureLen := mload(add(add(signature, s), 0x20))
            }

            require(uint256(s).add(32).add(contractSignatureLen) <= signature.length, "bad signature bytes");
            require(uint256(s).add(32) <= signature.length, "bad signature bytes (len too long)");

            bytes memory contractSignature;
            // solhint-disable-next-line no-inline-assembly
            assembly {
            // The signature data for contract signatures is appended to the concatenated signatures and the offset is stored in s
                contractSignature := add(add(signature, s), 0x20)
            }

            require(ISignatureValidator(currentWallet).isValidSignature(data, contractSignature) == EIP1271_MAGIC_VALUE);



        } else if (v == 1) {
            // If v is 1 then it is an approved hash
            // When handling approved hashes the address of the approver is encoded into r
            currentWallet = address(uint160(uint256(r)));
            // Hashes are automatically approved by the sender of the message or when they have been pre-approved via a separate transaction
            require(msg.sender == currentWallet|| approvedHashes[currentWallet][dataHash] != 0, "bad sender or not approved hash");
        } else if (v > 30) {
            // If v > 30 then default va (27,28) has been adjusted for eth_sign flow
            // To support eth_sign and similar we adjust v and hash the messageHash with the Ethereum message prefix before applying ecrecover
            currentWallet= ecrecover(keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", dataHash)), v - 4, r, s);
        } else {
            // Default is the ecrecover flow with the provided data hash
            // Use ecrecover with the messageHash for EOA signatures
            currentWallet = ecrecover(dataHash, v, r, s);
        }



    }

    function executeTransaction(ERC2055Tx memory _data, bytes memory signature) public payable virtual returns(bool success) {
        bytes32 txHash;
        {
            bytes memory txHashData = encodeTxData(_data);
            incrementNonce();
            txHash = keccak256(txHashData);
            checkSignature(txHash, txHashData, signature);
        }
         // We require some gas to emit the events (at least 2500) after the execution and some to perform code until the execution (500)
        // We also include the 1/64 in the check that is not send along with a call to counteract potential shortings because of EIP-150
        require(gasleft() >= max((_data.safeTxGas * 64) / 63,(_data.safeTxGas + 2500) + 500), "gas error");
    }

    function requiredTxGas(
        address to,
        uint256 value,
        bytes calldata data,
        Operation operation
    ) external returns (uint256) {
        uint256 startGas = gasleft();
        // We don't provide an error message here, as we use it to return the estimate
        require(execute(to, value, data, operation, gasleft()));
        uint256 requiredGas = startGas - gasleft();
        // Convert response to string and return via error message
        revert(string(abi.encodePacked(requiredGas)));
    }

    function execute(
        address to,
        uint256 value,
        bytes memory data,
        Operation operation,
        uint256 txGas
    ) internal returns (bool success) {
        if (operation == Operation.DelegateCall) {
            // solhint-disable-next-line no-inline-assembly
            assembly {
                success := delegatecall(txGas, to, add(data, 0x20), mload(data), 0, 0)
            }
        } else {
            // solhint-disable-next-line no-inline-assembly
            assembly {
                success := call(txGas, to, value, add(data, 0x20), mload(data), 0, 0)
            }
        }
    }

    function signatureSplit(bytes memory signatures, uint256 pos)
    internal
    pure
    returns (
        uint8 v,
        bytes32 r,
        bytes32 s
    )
    {
        // The signature format is a compact form of:
        //   {bytes32 r}{bytes32 s}{uint8 v}
        // Compact means, uint8 is not padded to 32 bytes.
        // solhint-disable-next-line no-inline-assembly
        assembly {
            let signaturePos := mul(0x41, pos)
            r := mload(add(signatures, add(signaturePos, 0x20)))
            s := mload(add(signatures, add(signaturePos, 0x40)))
        // Here we are loading the last 32 bytes, including 31 bytes
        // of 's'. There is no 'mload8' to do this.
        //
        // 'byte' is not working due to the Solidity parser, so lets
        // use the second best option, 'and'
            v := and(mload(add(signatures, add(signaturePos, 0x41))), 0xff)
        }
    }




}