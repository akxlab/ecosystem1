// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

bytes32 constant STATE_INIT = keccak256(abi.encodePacked("STATE_INIT"));
bytes32 constant STATE_PAUSED = keccak256(abi.encodePacked("STATE_PAUSED"));
bytes32 constant STATE_VIPSALE = keccak256(abi.encodePacked("STATE_VIPSALE"));
bytes32 constant STATE_UPKEEP = keccak256(abi.encodePacked("STATE_UPKEEP"));
bytes32 constant STATE_NORMAL = keccak256(abi.encodePacked("STATE_NORMAL"));

contract AKXGateway is Proxy, ERC1967Proxy {

    bytes32 public state;
    bytes32 internal nextState;

    constructor(address labzToken, address vipToken, address uds, address _implementation, bytes memory _data) ERC1967Proxy(_implementation, _data) {
        state = STATE_INIT;
        nextState = STATE_PAUSED;
    }

    function initialize() internal onlyIsInit {
        state = nextState;
        nextState = STATE_VIPSALE;
    }

    function _startVipSale() internal notVIP {
            state = nextState;
            nextState = STATE_NORMAL;
    }

    function _startUpKeep() internal notUpkeep {
        state = STATE_UPKEEP;
        nextState = STATE_NORMAL;
    }

    modifier notVIP() {
        require(state != STATE_VIPSALE, "gateway is in VIP SALE mode");
        _;
    }

    modifier notPaused() {
        require(state != STATE_PAUSED, "gateway is paused");
        _;
    }

    modifier notInit() {
        require(state != STATE_INIT, "gateway is initializing");
        _;
    }

    modifier notUpkeep() {
        require(state != STATE_UPKEEP, "gateway is in upkeep state");
        _;
    }

    modifier onlyIsInit() {
        require(state == STATE_INIT, "gateway is not initializing");
        _;
    }

}