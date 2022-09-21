// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../AKXLogo.sol";
import "@openzeppelin/contracts/utils/Base64.sol";


contract AKXERC721 is ERC721 {

    constructor() ERC721("AKX3 LOGO", "AKXLOGO") {
        
    }


    function tokenURI(uint256 tokenId) override public view returns (string memory) {
        string memory logo = AKXLogoSVG;
         string memory json = Base64.encode(bytes(string(abi.encodePacked('{"name": "AKX3 LOGO", "AKX3 Logo Icon": "", "image_data": "', bytes(logo), '"}'))));
    return string(abi.encodePacked('data:application/json;base64,', json));
    }

}