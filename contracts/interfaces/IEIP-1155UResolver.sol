// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

/**
 * @notice draft proposal IEIP-1155UResolver as a required interface to resolve EIP1155 bytes32 ids to uint256
 */

interface IEIP1155UResolver {

    event AddedToEIP1155UResolver(bytes32 id, uint256 tokenId);

    struct ResolverRequest {
        bytes32 id;
        address from;
    }

    struct ResolverResponse {
        uint256 tokenId;
        address to;
        bytes data;
        bool isError;
        string errMsg;
    }

    function resolve(ResolverRequest memory) external returns(ResolverResponse memory);
    function addToResolver(bytes32 id, address owner, uint256 tokenId) external;
    function isResolvable(bytes32 id, address owner) external returns(bool);

}