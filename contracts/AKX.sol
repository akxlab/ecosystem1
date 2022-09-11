// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./interfaces/IAKX.sol";
import "./Auth.sol";
import "./Roles.sol";
import "./AKXMetas.sol";
import "./AKXSetup.sol";
import "./utils/InitModifiers.sol";

import "@openzeppelin/contracts/access/AccessControlEnumerable.sol";

abstract contract AKXStates {
    bytes32 public CURRENT_STATE;
    bytes32 public NEXT_STATE;
    bytes32 public PREV_STATE;
    bytes32 public constant VIP_SALE_STATE = keccak256("VIP_SALE_STATE");
    bytes32 public constant PUBLIC_STATE = keccak256("PUBLIC_STATE");
    bytes32 public constant PAUSED_STATE = keccak256("PAUSED_STATE");
    bytes32 public constant NOHUMAN_STATE = keccak256("NOHUMAN_STATE"); // the state the contract is in when we renounce ownership after the vip sale, fully decentralized with the DAO as owner

    function triggerNextState() internal virtual;
}


contract AKXEcosystem is
InitModifiers,
AKXSetup,
IAKX,
AKXStates,
AKXRoles,
AKXMetas,
AccessControlEnumerable,
Auth
{
    constructor(address[6] memory _contracts) {
        initialize(_contracts[1], _contracts[2], _contracts[3], _contracts[4], _contracts[5], _contracts[6]);
    }


    function initialize(address ethrdid, address labztoken, address uds, address dex, address gov, address akxtoken) public onlyNotInitialized {
        _setEthrDid(ethrdid);
        _setLabzToken(labztoken);
        _setUDS(uds);
        _setDEX(dex);
        _setGov(gov);
        _setAkxToken(akxtoken);
        __AKX_Ecosystem_init();
        setInitialized();
    }

    function __AKX_Ecosystem_init() public onlyNotInitialized {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _setupRole(AKX_OPERATOR_ROLE, msg.sender);
        _setupRole(LABZ_OPERATOR_ROLE, msg.sender);
        _setupRole(UPGRADER_OPERATOR_ROLE, msg.sender);
        _grantRole(AKX_OPERATOR_ROLE, msg.sender);
        _grantRole(LABZ_OPERATOR_ROLE, msg.sender);
        _grantRole(UPGRADER_OPERATOR_ROLE, msg.sender);
        setVersion("1.0.0");
        setName("AKX3 ECOSYSTEM");
        _setVIPSale();
    }

    function _setVIPSale() internal {
        CURRENT_STATE = VIP_SALE_STATE;
        NEXT_STATE = PUBLIC_STATE;
    }

    function setFoundersAddresses(address[] memory _founders) public onlyRole(AKX_OPERATOR_ROLE) {
        setFounders(_founders);
    }

    function setMultiSignatureWallet(address _multi) public onlyRole(AKX_OPERATOR_ROLE) {

    }

    function EthDIDRegistry() external view override returns (DidRegistry) {
        return DidRegistry(ethrDidRegistry);
    }

    function LabzToken() external view returns (LabzERC2055) {
        return LabzERC2055(payable(labzToken));
    }

    function UserDataService() external view returns (UserDataServiceResolver) {
        return UserDataServiceResolver(userDataService);
    }

    function DexToken(address token) external pure returns (IERC2055) {
        return IERC2055(token);
    }


    function triggerNextState() internal virtual override {
        PREV_STATE = CURRENT_STATE;
        CURRENT_STATE = NEXT_STATE;
    }

    function triggerNextStateAuto(uint256 _value) public onlyRole(AKX_OPERATOR_ROLE) {
        require(msg.sender == address(this), "only self is allowed");
        if (block.timestamp > _value) {
            triggerNextState();
        } else if (this.LabzToken().totalSupply() == _value) {
            triggerNextState();
        }
    }

    function setDAOAsOwner(address _daoAddress) external onlyRole(AKX_OPERATOR_ROLE) {
        _revokeRole(AKX_OPERATOR_ROLE, msg.sender);
        _grantRole(AKX_OPERATOR_ROLE, _daoAddress);
        _grantRole(UPGRADER_OPERATOR_ROLE, _daoAddress);
    }
}
