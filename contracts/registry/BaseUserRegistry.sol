// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "../interfaces/IEIP721U.sol";
import "../modules/uds/UDS.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BaseUserRegistry is ERC721, Ownable {

    mapping(address => bool) public controllers;
    bytes4 private constant INTERFACE_META_ID = bytes4(keccak256("supportsInterface(bytes4)"));
    mapping(uint256 => mapping(uint256 => bool))  private registrationQueue;


    UDS public uds;
    uint256 internal index;
    bytes32 public rootNodeAddress; // will be used in layer 2

    bytes4 private constant ERC721_ID =
    bytes4(
        keccak256("balanceOf(address)") ^
        keccak256("ownerOf(uint256)") ^
        keccak256("approve(address,uint256)") ^
        keccak256("getApproved(uint256)") ^
        keccak256("setApprovalForAll(address,bool)") ^
        keccak256("isApprovedForAll(address,address)") ^
        keccak256("transferFrom(address,address,uint256)") ^
        keccak256("safeTransferFrom(address,address,uint256)") ^
        keccak256("safeTransferFrom(address,address,uint256,bytes)")
    );
    bytes4 private constant RECLAIM_ID = bytes4(keccak256("reclaim(uint256,address)"));
    bytes4 private constant REPUTATION_ID = bytes4(keccak256("reputation(uint256)"));

    function _isApprovedOrOwner(address spender, uint256 tokenId)
    internal
    view
    override
    returns (bool)
    {
        address owner = ownerOf(tokenId);
        return (spender == owner ||
        getApproved(tokenId) == spender ||
        isApprovedForAll(owner, spender));
    }


    constructor(bytes32 rootNode, address _uds) ERC721("","") {
        uds = UDS(_uds);
        rootNodeAddress = rootNode;
        index = 0;
    }

    modifier onlyLive() {
        require(uds.owner(rootNodeAddress) == msg.sender);
        _;
    }

    modifier onlyController() {
        require(controllers[msg.sender]);
        _;
    }

    function authorizeController(address controller) external  onlyOwner {
        controllers[controller] = true;
    }

    function deAuthorizeController(address controller) external  onlyOwner {
        controllers[controller] = false;
    }

    function setResolver(address resolver) external  onlyOwner {
        uds.setResolver(rootNodeAddress, resolver);
    }

    function register(uint256 tokenId, address owner) external returns (uint256) {
        return _register(tokenId, owner, true);
    }

    function register(address owner) external returns (uint256) {
        uint tokenId = index++;
        return _register(tokenId, owner, true);
    }


    function _register(uint256 tokenId, address owner, bool update) internal  returns (uint256) {

        if(_exists(tokenId)) {
            _burn(tokenId);
        }

        registrationQueue[index][tokenId] = true;

        super._safeMint(owner, tokenId);

        registrationQueue[index][tokenId] = false;


        return index;

    }

    function supportsInterface(bytes4 interfaceID)
    public
    view
    override(ERC721)
    returns (bool)
    {
        return
        interfaceID == INTERFACE_META_ID ||
        interfaceID == ERC721_ID ||
        interfaceID == REPUTATION_ID ||
        interfaceID == RECLAIM_ID;
    }
}