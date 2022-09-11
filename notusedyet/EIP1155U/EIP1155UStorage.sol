// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@openzeppelin/contracts/utils/Strings.sol";
import "./EIP1155U.sol";

abstract contract EIP1155UStorage is EIP1155U {
using Strings for uint256;

 // Optional base URI
    string private _baseURI = "";

    // Optional mapping for token URIs
    mapping(uint256 => string) private _tokenURIs;

     function uri(uint256 tokenId) public view virtual override returns (string memory) {
        string memory tokenURI = _tokenURIs[tokenId];

        // If token URI is set, concatenate base URI and tokenURI (via abi.encodePacked).
        return bytes(tokenURI).length > 0 ? string(abi.encodePacked(_baseURI, tokenURI)) : super.uri(tokenId);
    }

}