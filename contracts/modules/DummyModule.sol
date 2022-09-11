// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;


import "./BaseModule.sol";
import "./ModuleRegistry.sol";
import "../interfaces/IModuleRegistry.sol";

contract DummyModule is Initializable, BaseModule {

    ModuleRegistry internal _registry;
    IModuleRegistry.Module internal loadedModule;

    function initialize(address _reg) public initializer {
        _registry = ModuleRegistry(_reg);
        __init_module();
    }

    function loadModule(bytes32 _name, string memory version)
        external
        override
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
        _moduleName = keccak256(abi.encodePacked("DummyModule"));
        _moduleContract = address(0);
        _moduleAuthor = keccak256(abi.encodePacked("AKX3"));
        _moduleVersion = "1";
        _registry.registerModule(address(this), "DummyModule");
        _loaded = false;
    }
}