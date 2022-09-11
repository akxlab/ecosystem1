// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "../ERC2055Storage.sol";
import "../ERC2055.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract ERC2055Implementation is ERC2055, ERC2055Storage {
    using Counters for Counters.Counter;
    Counters.Counter internal tokenIndex;

    mapping(address => bool) private _pending;
    mapping(address => uint256) private _queueIds;
    mapping(address => bool) private _exists;
    address[] private tokenQueue;

    uint256 public numTokens;

    uint256 public baseFee;


    Counters.Counter internal tqIndex; // token queue index

    event ERC2055Minted(address indexed underlying, string name, string symbol);

    constructor(string memory _name, string memory _symbol)
        ERC2055(_name, _symbol)
    {}

    function addToken(address erc2055Token) public onlyOwner returns (bool) {
        require(_pending[erc2055Token] != true, "token is already pending queue");
        uint256 _tokenId = tqIndex.current();

        tqIndex.increment();
        return true;
    }

    function _addToQueue(address t, uint256 tid) internal returns (bool) {
        require(_exists[t] != true, "token already exists");
        _pending[t] = true;
        _queueIds[t] = tid;
        tokenQueue[tid] = t;
        return true;
    }

    function _mint(address erc2055Token, uint256 tid) internal override  {
        require(_addToQueue(erc2055Token, tid), "ERC2055: CANNOT ADD TO QUEUE");
        Token memory _tok = _setToken(erc2055Token);
        _tokens[tid] = _tok;
        setUnderlyingName(tid);
        _tokenIds.push(tid);
        delete _pending[erc2055Token];
        delete _queueIds[erc2055Token];
        delete tokenQueue[tid];
        _exists[erc2055Token] = true;
        numTokens += 1;
        emit ERC2055Minted(erc2055Token, tokenName(tid), tokenSymbol(tid));


    }



    function _setToken(address _token) internal view returns(Token memory _tok) {
        ERC2055 _t = ERC2055(_token);
        _tok = Token(_t.name(), _t.symbol(), _t.totalSupply(), _t.maxSupply(),_t.decimals());
    }

    function setUnderlyingName(uint256 tokenId) internal {
        string memory thissymbol = ERC2055(address(this)).symbol();
        string memory underlyingName = _underlyings[tokenId].name();
        string memory underlyingSymbol = _underlyings[tokenId].symbol();
        names[tokenId] = string.concat(thissymbol, underlyingName);
        symbols[tokenId] = string.concat(thissymbol, underlyingSymbol);
    }

    function _underlyingName(uint256 tokenId)
        internal view
        returns (string memory __underlyingName)
    {
        __underlyingName = names[tokenId];
    }

    function _underlyingSymbol(uint256 tokenId)
        internal view
        returns (string memory __underlyingSymbol)
    {
        __underlyingSymbol = symbols[tokenId];
    }

    function tokenName(uint256 tokenId) public view returns (string memory) {
        return _underlyingName(tokenId);
    }

    function tokenSymbol(uint256 tokenId) public view returns (string memory) {
        return _underlyingSymbol(tokenId);
    }

    function getToken(uint256 tokenId) external view returns(address tokenAddress) {
        tokenAddress = _tokenIdtoAddresses[tokenId];
    }
}
