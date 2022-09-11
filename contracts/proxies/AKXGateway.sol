// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";
import "../LabzERC2055/LabzERC2055.sol";
import "../resolvers/RoutesResolver.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlEnumerableUpgradeable.sol";

bytes32 constant STATE_INIT = keccak256(abi.encodePacked("STATE_INIT"));
bytes32 constant STATE_PAUSED = keccak256(abi.encodePacked("STATE_PAUSED"));
bytes32 constant STATE_VIPSALE = keccak256(abi.encodePacked("STATE_VIPSALE"));
bytes32 constant STATE_UPKEEP = keccak256(abi.encodePacked("STATE_UPKEEP"));
bytes32 constant STATE_NORMAL = keccak256(abi.encodePacked("STATE_NORMAL"));

bytes32 constant ROUTE_LABZ_BUY_VIP = keccak256(abi.encodePacked("BUY_VIP"));

contract AKXGateway is UUPSUpgradeable, RoutesResolver {
    bytes32 public state;
    bytes32 internal nextState;

    constructor(
        address labzToken,
        address vipToken,
        address uds,
        address _implementation,
        bytes memory _data
    ) {
        state = STATE_INIT;
        nextState = STATE_PAUSED;
    }

    function routeLabz(bytes calldata data) external {}

    function routeTo(
        bytes4 interfaceId,
        address to,
        bytes calldata _datachmoi
    ) external {
        (bool success, ) = to.call(abi.encodeWithSelector(interfaceId, _data));
        require(success);
    }

    function _authorizeUpgrade(address) internal override {}

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

    function _beforeRouting(bytes32 _routeName) internal virtual override {}
}