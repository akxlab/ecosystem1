// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./NonCustodial.sol";
import "../../tokens/ERC2055/utils/Transaction.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts/token/ERC777/IERC777Recipient.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";
import "../../utils/InitModifiers.sol";
import "./FallbackManager.sol";


contract AkxWallet is ERC165, NonCustodialWallet, IERC1155Receiver, IERC777Recipient, IERC721Receiver, InitModifiers, ERC2055Transaction, FallbackManager {
    address private immutable multisendSingleton;
    address private immutable singleton;

    bytes4 internal constant UPDATED_MAGIC_VALUE = 0x1626ba7e;
    using Math for uint256;

    bytes32 private constant AKX_MSG_TYPEHASH = keccak256("akxMessage(bytes message)");

    string public constant VERSION = "1.0.0";

    event SignMsg(bytes32 indexed msgHash);
    event AkxWalletReceived(address indexed sender, uint256 value);
    mapping(bytes32 => uint256) public  _signedMessages;

    constructor() {
        multisendSingleton = address(this);
        singleton = address(this);
    }


    function initialize(address _owner) public onlyNotInitialized {

    }

    function isValidSignature(bytes memory _data, bytes memory _signature) public view virtual override returns (bytes4) {
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



    /// @dev Marks a message as signed, so that it can be used with EIP-1271
    /// @notice Marks a message (`_data`) as signed.
    /// @param _data Arbitrary length data that should be marked as signed on the behalf of address(this)
    function signMessage(bytes calldata _data) external {
        bytes32 msgHash = getMessageHash(_data);
        _signedMessages[msgHash] = 1;
        emit SignMsg(msgHash);
    }

    /// @dev Returns hash of a message that can be signed by owners.
    /// @param message Message that should be hashed
    /// @return Message hash.
    function getMessageHash(bytes memory message) public view virtual returns (bytes32) {
        bytes32 akxMessageHash = keccak256(abi.encode(AKX_MSG_TYPEHASH, keccak256(message)));
        return
        keccak256(abi.encodePacked(bytes1(0x19), bytes1(0x01), AkxWallet(payable(address(this))).domainSeparator(), akxMessageHash));
    }

    function isValidSignature(bytes32 _dataHash, bytes calldata _signature) external view virtual  returns (bytes4) {
        ISignatureValidator validator = ISignatureValidator(msg.sender);
        bytes4 value = validator.isValidSignature(abi.encode(_dataHash), _signature);
        return UPDATED_MAGIC_VALUE;
    }



    function getMessageHashForWallet(AkxWallet wallet, bytes memory message) public view virtual  returns (bytes32) {
        bytes32 walletMessageHash = keccak256(abi.encode(AKX_MSG_TYPEHASH, keccak256(message)));
        return keccak256(abi.encodePacked(bytes1(0x19), bytes1(0x01), wallet.domainSeparator(), walletMessageHash));
    }

    function onERC1155Received(
        address,
        address,
        uint256,
        uint256,
        bytes calldata
    ) external pure override returns (bytes4) {
        return 0xf23a6e61;
    }

    function onERC1155BatchReceived(
        address,
        address,
        uint256[] calldata,
        uint256[] calldata,
        bytes calldata
    ) external pure override returns (bytes4) {
        return 0xbc197c81;
    }

    function onERC721Received(
        address,
        address,
        uint256,
        bytes calldata
    ) external pure override returns (bytes4) {
        return 0x150b7a02;
    }

    function tokensReceived(
        address,
        address,
        address,
        uint256,
        bytes calldata,
        bytes calldata
    ) external pure override {
        // We implement this for completeness, doesn't really have any value
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC165, IERC165) returns (bool) {
        return
        interfaceId == type(IERC1155Receiver).interfaceId ||
        interfaceId == type(IERC721Receiver).interfaceId ||
        interfaceId == type(IERC165).interfaceId;
    }

    function _msgSender() internal pure returns (address sender) {
        // The assembly code is more direct than the Solidity version using `abi.decode`.
        // solhint-disable-next-line no-inline-assembly
        assembly {
            sender := shr(96, calldataload(sub(calldatasize(), 20)))
        }
    }

    /// @dev Sends multiple transactions and reverts all if one fails.
    /// @param transactions Encoded transactions. Each transaction is encoded as a packed bytes of
    ///                     operation as a uint8 with 0 for a call or 1 for a delegatecall (=> 1 byte),
    ///                     to as a address (=> 20 bytes),
    ///                     value as a uint256 (=> 32 bytes),
    ///                     data length as a uint256 (=> 32 bytes),
    ///                     data as bytes.
    ///                     see abi.encodePacked for more information on packed encoding
    /// @notice This method is payable as delegatecalls keep the msg.value from the previous call
    ///         If the calling method (e.g. execTransaction) received ETH this would revert otherwise
    function multiSend(bytes memory transactions) public payable {
        require(address(this) != multisendSingleton, "MultiSend should only be called via delegatecall");
        // solhint-disable-next-line no-inline-assembly
        assembly {
            let length := mload(transactions)
            let i := 0x20
            for {
            // Pre block is not used in "while mode"
            } lt(i, length) {
            // Post block is not used in "while mode"
            } {
            // First byte of the data is the operation.
            // We shift by 248 bits (256 - 8 [operation byte]) it right since mload will always load 32 bytes (a word).
            // This will also zero out unused data.
                let operation := shr(0xf8, mload(add(transactions, i)))
            // We offset the load address by 1 byte (operation byte)
            // We shift it right by 96 bits (256 - 160 [20 address bytes]) to right-align the data and zero out unused data.
                let to := shr(0x60, mload(add(transactions, add(i, 0x01))))
            // We offset the load address by 21 byte (operation byte + 20 address bytes)
                let value := mload(add(transactions, add(i, 0x15)))
            // We offset the load address by 53 byte (operation byte + 20 address bytes + 32 value bytes)
                let dataLength := mload(add(transactions, add(i, 0x35)))
            // We offset the load address by 85 byte (operation byte + 20 address bytes + 32 value bytes + 32 data length bytes)
                let data := add(transactions, add(i, 0x55))
                let success := 0
                switch operation
                case 0 {
                    success := call(gas(), to, value, data, dataLength, 0, 0)
                }
                case 1 {
                    success := delegatecall(gas(), to, data, dataLength, 0, 0)
                }
                if eq(success, 0) {
                    revert(0, 0)
                }
            // Next entry starts at 85 byte + data length
                i := add(i, add(0x55, dataLength))
            }
        }
    }



    /// @dev Fallback function accepts Ether transactions.
    receive() external payable {
        emit AkxWalletReceived(msg.sender, msg.value);
    }

}