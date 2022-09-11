// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;


interface IERC2055Storage {

    enum ContentType {
        STRING,
        BIGNUMBER,
        ADDRESS,
        BYTES32,
        BYTES,
        STRUCT
    }

    struct StoreItem {
        bytes32 itemId;
        bytes data;
        ContentType contentType;
        bytes32 hash;
    }

    event Stored(address indexed from, bytes32 _storeItemId);

    function store(StoreItem memory item) external;
    function retrieve(bytes32 itemId) external returns(StoreItem memory item);
    function retrieveByHash(bytes32 hash) external returns(StoreItem memory item);
    function decodeData(bytes32 itemId) external returns(bytes calldata _data);


}