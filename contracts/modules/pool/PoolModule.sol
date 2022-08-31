// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;


import "../BaseModule.sol";
import "../ModuleRegistry.sol";
import "../../interfaces/IModuleRegistry.sol";

contract PoolModule is Initializable, BaseModule {

    address public implementation;
    address public admin;
    address public registry;
    ModuleRegistry internal _registry;
    IModuleRegistry.Module internal loadedModule;

    constructor() {
        admin = msg.sender;
    }
    

 function initialize(address _reg) public initializer {
    implementation = _reg;
        _registry = ModuleRegistry(_reg);
        __init_module();
    }

   function loadModule(bytes32 _name, string memory version)
        external
        override
        onlyOwner 
    {
        require(_loaded == false, "already loaded");
        require(_name == _moduleName, "invalid name");
        string memory _ver = _moduleVersion;
        require(this.compareVersions(version, _ver), "invalid version");
        _load();
        _loaded = true;
        emit ModuleAdded(_moduleName);
    }

    function _load() internal virtual override {
        loadedModule = _registry.getModule(_moduleName);
    }

    function _unload() internal virtual override {
        require(_loaded == true, "module not loaded");
        _registry.deregisterModule(_moduleContract);
        emit ModuleRemoved(_moduleName);
    }

    function __init_module() internal virtual override {
        _moduleName = keccak256(abi.encodePacked("PoolModule"));
        _moduleContract = implementation;
        _moduleAuthor = keccak256(abi.encodePacked("AKX3"));
        _moduleVersion = "1";
        _registry.registerModule(address(this), "PoolModule");
        _loaded = false;
    }

   

    modifier onlyOwner() {
        require(msg.sender == admin, "only owner allowed");
        _;
    }
}