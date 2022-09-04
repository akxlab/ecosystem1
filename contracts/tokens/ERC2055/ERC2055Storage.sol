// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "./ERC2055.sol";


abstract contract ERC2055Storage {
    mapping(uint256 => address) private _tokenIdtoAddresses;
    mapping(uint256 => address) public ownerOf;
    mapping(uint256 => string) public names;
    mapping(uint256 => string) public symbols;
    mapping(uint256 => uint256) public supply;
    mapping(uint256 => uint8) public decimals;
    mapping(uint256 => mapping(address => uint256)) internal _balances;
    mapping(address => mapping(uint256 => Balances[])) internal _tokenBalances;
    mapping(uint256 => mapping(address => uint256)) public allowances;
    mapping(address => uint256[]) public _holdsTokenIds;
    mapping(uint256 => Token) internal _tokens;
    mapping(uint256 => OptionalTokenMetas) private _optionalMetas;
    mapping(uint256 => bool) internal _hasMetas;
    mapping(uint256 => ERC2055) internal _underlyings;
    uint256[] internal _tokenIds;

    struct Balances {
        address owner;
        address token;
        uint256 tokenId;
        uint256 amount;
    }

    struct Token {
        string name;
        string symbol;
        uint256 totalSupply;
        uint256 maxSupply;
        uint8 decimals;
    }

    struct OptionalTokenMetas {
        string logoUri;
        string website;
        string whitepaper;
        string[] socialLinks;
        address[] founders;
        address[] sponsors;
        string[] akas;
        string[] networks;
        uint256[] chainIds;
    }

    function tokenIds() public view returns(uint256[] memory) {
        return _tokenIds;
    }

    function balancesOf(address holder) external view returns(Balances[] memory) {
        uint i = 0;
        Balances[] memory b;
        for(i == 0; i < _holdsTokenIds[holder].length; i+=1) {
            uint256 tid = _holdsTokenIds[holder][i];
            b[i] = Balances(holder, _tokenIdtoAddresses[tid],tid, _balances[tid][holder]);
        }
        return b;
    }

    function token(uint256 tokenId) external view returns (Token memory) {
        return _tokens[tokenId];
    }

    function _tName(uint256 tokenId)  external view returns (string memory) {
        return this.token(tokenId).name;
    }

    function _tSymbol(uint256 tokenId) external view returns (string memory) {
         return this.token(tokenId).symbol;
    }

    function _tDecimal(uint256 tokenId) external view returns (uint8) {
         return this.token(tokenId).decimals;
    }


    function _tTotalSupply(uint256 tokenId) external view returns (uint256) {
         return this.token(tokenId).totalSupply;
    }

    function _tMaxSupply(uint256 tokenId) external view returns (uint256) {
         return this.token(tokenId).maxSupply;
    }

    function metas(uint256 tokenId) external view returns(OptionalTokenMetas memory opts) {
     
       string[] memory socials;
       address[] memory founders;
       address[] memory sponsors;
       string[] memory akas;
       string[] memory networks;
       uint256[] memory chainIds;

        if(_hasMetas[tokenId] != true) {
        opts = OptionalTokenMetas(
            "",
            "",
            "",
            socials,
            founders,
            sponsors,
            akas,
            networks,
            chainIds);
        } else {
            opts = _optionalMetas[tokenId];
        }

    }



}