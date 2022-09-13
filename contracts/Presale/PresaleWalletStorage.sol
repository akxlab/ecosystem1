// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/utils/Counters.sol";

abstract contract PresaleWalletStorage {

    using Counters for Counters.Counter;

    struct WalletStorageIndexer {
        mapping(address => uint256) walletIndex;
        uint256 _count;
    }

    struct WalletStorage {
        uint256 index;
        bytes32 ident;
        address owner;
        address wallet;
        bool active;
    }

    struct Wallets {
        WalletStorage[] walletDirectory;
    }

    mapping(uint256 => bytes32) private _walletHashes;
    bytes32[] _hashes;

    Counters.Counter private _index;

    function getStorage() internal returns(Wallets storage ws) {
        bytes32 WalletStorageTypeID = keccak256("akx3.ecosystem.wallet.storage");
        assembly {
            ws := WalletStorageTypeID.slot
        }
    }

    function getIndexer() internal returns(WalletStorageIndexer storage _wsi) {
        bytes32 WalletIndexerTypeID = keccak256("akx3.ecosystem.wallet.indexer");
        assembly {
            _wsi := WalletIndexerTypeID.slot
        }
    }

    function store(bytes32 ident, address _owner, address _wallet) internal returns(bool success) {
        Wallets storage ws = getStorage();
        uint256 __index = _index.current();
        _index.increment(); // prevent race condition
        ws.walletDirectory[__index].ident = ident;
        ws.walletDirectory[__index].owner = _owner;
        ws.walletDirectory[__index].wallet = _wallet;
        ws.walletDirectory[__index].index = __index;
        ws.walletDirectory[__index].active = true;

        bytes memory walletBytes = abi.encode(ws.walletDirectory[__index]);
        bytes32 walletHash = sha256(walletBytes);
        _walletHashes[__index] = walletHash;
        _hashes.push(walletHash);

        // need to index the wallets
        WalletStorageIndexer storage _wsi = getIndexer();
        _wsi.walletIndex[_owner] = __index;

        success = true;
    }

    function retrieve(address _owner) internal returns(WalletStorage memory _wallet) {
        WalletStorageIndexer storage _wsi = getIndexer();
        Wallets storage ws = getStorage();
        uint256 __index = _wsi.walletIndex[_owner];
        _wallet = ws.walletDirectory[__index];
    }




}