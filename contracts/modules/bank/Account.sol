// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;


import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "../../utils/BytesUtils.sol";
import "../../utils/IsSelf.sol";
import "../../utils/InitModifiers.sol";

contract Account is BytesUtils, IsSelf, InitModifiers, Ownable, ReentrancyGuard {

    using Counters for Counters.Counter;

    Counters.Counter private _signRequestId;
    Counters.Counter private _newSignReqId;

    event SignatureVerificationRequest(uint256 reqId, bytes32 signatureId, bytes pubkey);
    event SignAccountRequest(uint256 reqId, bytes accountAddress, bytes pubkey);


    mapping(uint => mapping(bytes32 => bool)) private _pendingTxHashes;
    mapping(uint256 => bool) private _pendingSignatureVerification;
    mapping(uint256 => bool) private _signatureVerification;
    mapping(bytes32 => uint256) private _txToVerificationReqIds;
    mapping(uint256 => bool) private _pendingSign;
    mapping(uint256 => bytes) private _signatures;

    address public _accountOwner;
    string public _accountType;
    bytes accountSignature;
    address payable accountAddress;


    bytes private pubKey;

    // to set the crystal-dilithium packed pub key parts
    function setKeyParts(bytes memory data) external onlyOwner {

        pubKey = abi.encode(data);
    }


    // generate account address from crystal-dilithium packed pub key
    function setAccountAddress() internal {
        accountAddress = bytesToAddress(pubKey);
    }

    function verifyDilithiumSignature(bytes32 signatureId) external onlyOwner  {
        _pendingSignatureVerification[_signRequestId.current()] = true;
        emit SignatureVerificationRequest(_signRequestId.current(), signatureId, pubKey);
        _signRequestId.increment();
    }

    function setSignatureVerificationResult(uint256 _reqId, uint result) external onlyOwner{
        require(_pendingSignatureVerification[_reqId], "invalid request id");
        delete _pendingSignatureVerification[_reqId];
       _signatureVerification[_reqId] = result == 1 ? true : false;
    }

    function signAccount(address payable _toSign) internal {
        uint256 reqId = _newSignReqId.current();
        _pendingSign[reqId] = true;
        emit SignAccountRequest(reqId, addressToBytes(_toSign), pubKey);

    }

    function initialize(address _for, string memory _aType, bytes memory keyParts) public onlyNotInitialized {
        _accountOwner = _for;
        _accountType = _aType;
        this.setKeyParts(keyParts);
        setAccountAddress();
        address payable accAddress = getAccountAddress();
        signAccount(accAddress);
    }

    function setAccountSignature(uint256 reqId, bytes memory signature) public onlyOwner  {
        require(_pendingSign[reqId], "invalid request");
        accountSignature = abi.encode(signature);
        _newSignReqId.increment();
    }

    function getAccountAddress() public returns(address payable) {
        return accountAddress;
    }




}