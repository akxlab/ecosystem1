// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "../../resolvers/AllResolvers.sol";
import "./UDS.sol";
import "../../registry/BaseUserRegistry.sol";
import "../../controllers/BaseController.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract UserDataServiceResolver is AllResolvers, BaseUserRegistry {

    /**
 * A mapping of authorisations. An address that is authorised for a profile name
 * may make any changes to the name that the _owner could, but may not update
 * the set of authorisations.
 * (node,  _owner, caller) => isAuthorised
 */
    mapping(bytes32 => mapping(address => mapping(address => bool))) public authorisations;
    bytes4 private constant INTERFACE_META_ID = bytes4(keccak256("supportsInterface(bytes4)"));

    event AuthorisationChanged(bytes32 indexed profileId, address indexed  _owner, address indexed target, bool isAuthorised);
    event NewAccountCreated(bytes32 identity, address indexed  _owner, uint256 tokenId);
    event Log(string message);

    mapping(address => AccountInfo) private _info;

    using Counters for Counters.Counter;

   Counters.Counter internal _tokenIndex;

    struct AccountInfo {
        uint256 tokenId;
        bytes32 identity;
        address owner;
        bytes32 metasId;
        uint256 timestamp;
    }

    constructor(bytes32 rootNode, address _uds) BaseUserRegistry(rootNode, _uds){

    }


    function setAuthorisation(bytes32 profileId, address target, bool _isAuthorised) internal  {
        authorisations[profileId][msg.sender][target] = _isAuthorised;
        emit AuthorisationChanged(profileId, msg.sender, target, _isAuthorised);
    }

    function isAuthorised(bytes32 profileId) internal view returns (bool) {
        address _owner = uds.owner(profileId);
        return _owner == msg.sender || authorisations[profileId][_owner][msg.sender];
    }


    function multicall(bytes[] calldata data) internal returns (bytes[] memory results) {
        results = new bytes[](data.length);
        for (uint i = 0; i < data.length; i++) {
            (bool success, bytes memory result) = address(this).delegatecall(data[i]);
            require(success);
            results[i] = result;
        }
        return results;
    }

    function createNewAccount(address _accountWalletAddress, string memory accountName) public  {
         require(_createNewAccount(_accountWalletAddress), "error registering new account");
        setOptionalName(_accountWalletAddress, _tokenIndex.current(), accountName);
        _tokenIndex.increment();


    }

    function createNewAccount(address _accountWalletAddress) public {
        emit Log("create new account requested");
        require(_createNewAccount(_accountWalletAddress), "error registering new account");
_tokenIndex.increment();
    }

    function _createNewAccount(address accountOwner) internal returns (bool) {

        super._register(_tokenIndex.current(), accountOwner, true);
        emit Log("super._register is successful... requesting ident");
        bytes32 _ident = sha256(abi.encodePacked(_tokenIndex.current(), accountOwner));
        super.setIdent(_tokenIndex.current(), _ident);

        bytes32 metasId = setNewMetaDatas(_tokenIndex.current(), accountOwner);
        AccountInfo memory Info = setAccountInfoRecord(_tokenIndex.current(), _ident, accountOwner, metasId);
        emit NewAccountCreated(_ident, accountOwner, _tokenIndex.current());

        return true;
    }

    function setAccountInfoRecord(uint256 tokenId,
        bytes32 identity,
        address  _owner,
        bytes32 metasId) internal returns (AccountInfo memory){
        AccountInfo memory Info = AccountInfo(tokenId, identity,  _owner, metasId, block.timestamp);
        _info[_owner] = Info;
        return Info;
    }

    function getAccountInfo(address infoOwner) external view returns(AccountInfo memory Info) {
        Info = _info[infoOwner];
    }

    function concat(string memory _x, string memory _y) pure internal returns (string memory) {
        bytes memory _xBytes = bytes(_x);
        bytes memory _yBytes = bytes(_y);

        string memory _tmpValue = new string(_xBytes.length + _yBytes.length);
        bytes memory _newValue = bytes(_tmpValue);

        uint i;
        uint j;

        for(i=0;i<_xBytes.length;i++) {
            _newValue[j++] = _xBytes[i];
        }

        for(i=0;i<_yBytes.length;i++) {
            _newValue[j++] = _yBytes[i];
        }

        return string(_newValue);
    }

    function supportsInterface(bytes4 interfaceID)
    public
    view
    override(ERC721, AllResolvers)
    returns (bool)
    {

        return super.supportsInterface(interfaceID);
    }


}