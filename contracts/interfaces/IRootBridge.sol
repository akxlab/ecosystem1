// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "./IRootBridgeObserver.sol";
interface IRouteBridge {
     enum BridgeNetworks {
        POLYGON_MAINNET,
        POLYGON_MUMBAI,
        ETHEREUM_MAINNET,
        ETHEREUM_GOERLI,
        BINANCE_CHAIN_TESTNET,
        BINANCE_CHAIN_MAINNET,
        OPTIMISM_TEST,
        OPTIMISM_MAINNET
    }

    enum NonEVMChilds {
        BITCOIN_TESTNET,
        BITCOIN_MAINNET,
        DOGE_TESTNET,
        DOGE_MAINNET
    }

    function setRootBridgeObserver(address _observer) external;
    function setRootBridge(uint256 chainId, address rootBridge) external;
    function setChildBridge(uint256 chainId, address childBridge) external;
    function setNonEVMChildBridge(NonEVMChilds nonEvmBridgeID, uint256 txTemplateId) external;

}