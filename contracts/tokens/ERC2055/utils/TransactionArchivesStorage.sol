// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/access/Ownable.sol";

abstract contract TransactionArchivesStorage is Ownable {

    struct TXArchiveStorageItem {
        bytes32 txHash;
        uint256 timestamp;
        uint256 blockNumber;
        uint256 amount;
        bytes txData;
        bool status; // true if successful, false if not successful
    }

    struct TXArchiveStorage {
        mapping(bytes32 => TXArchiveStorageItem) items;
    }

    bytes32 private constant TX_ARCHIVE_STORAGE_SLOT = keccak256("akx3.ecosystem.txArchiveStorage");
    uint256 public archiveIndex;

    mapping(bytes32 => bool) private _txIsStored;
    mapping(address => mapping(uint => bytes32)) private _hashStoreBySender;
    mapping(bytes32 => bool) private _failed;
    mapping(bytes32 => bool) private _suspicious;

    function initTxArchiveStorage() private returns (TXArchiveStorage storage txa) {
        assembly {
            txa.slot := TX_ARCHIVE_STORAGE_SLOT
        }
    }

    function storeSuccessfulTransaction(address from, bytes32 txHash,
        uint256 timestamp,
        uint256 blockNumber,
        uint256 amount,
        bytes memory txData) public onlyOwner {
        TXArchiveStorageItem memory _txItem = TXArchiveStorageItem(txHash, timestamp, blockNumber, amount, txData, true);
        require(add(_txItem), "failed to add item to storage");
        _txIsStored[txHash] = true;
        _hashStoreBySender[from][archiveIndex] = txHash;
    }// )

    function storeFailedOrSuspiciousTransaction(address from, bytes32 txHash,
        uint256 timestamp,
        uint256 blockNumber,
        uint256 amount,
        bytes memory txData, bool isSuspicious) public onlyOwner {
        TXArchiveStorageItem memory _txItem = TXArchiveStorageItem(txHash, timestamp, blockNumber, amount, txData, true);
        require(add(_txItem), "failed to add item to storage");
        _txIsStored[txHash] = true;
        _hashStoreBySender[from][archiveIndex] = txHash;
        _failed[txHash] = true;
        _suspicious[txHash] = isSuspicious;
    }// )

    function add(TXArchiveStorageItem memory _item) internal returns (bool success) {
        //@dev tx archives are immutable and cannot and MUST NOT be updated or altered
        if (_txIsStored[_item.txHash]) {
            revert("tx already in storage");
        }
        TXArchiveStorage storage txa = initTxArchiveStorage();
        txa.items[_item.txHash] = _item;
        return true;
    }

    function retrieveByHash(bytes32 _hash) internal returns (TXArchiveStorageItem memory _item) {
        if (_txIsStored[_item.txHash] != true) {
            revert("tx not in storage");
        }
        TXArchiveStorage storage txa = initTxArchiveStorage();
        _item = txa.items[_hash];
    }


}