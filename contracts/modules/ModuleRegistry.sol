// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;


import "../interfaces/IModuleRegistry.sol";
import "../interfaces/IModule.sol";

contract ModuleRegistry is IModuleRegistry {
    mapping(bytes32 => address) private _moduleByName;
    mapping(address => bytes32) private _moduleByAddress;
    mapping(string => bytes32) private _moduleResolver;
    mapping(bytes32 => string) private _rModuleResolver;
    mapping(bytes32 => bool) private _isLoaded;
    mapping(address => bool) private _registeredAddress;
    mapping(bytes32 => bool) private _registeredName;
    mapping(bytes32 => Module) private _modules;

    function registerModule(address _module, string memory _sName) external {
        bytes32 _name = keccak256(abi.encodePacked(_sName));
        require(IModule(_module).moduleName() == _name, "names mismatch");
        require(
            this.isRegisteredModuleAddress(_module) != true,
            "address already registered"
        );
        require(
            this.isRegisteredModuleName(_name) != true,
            "name already registered"
        );
        _moduleByName[_name] = _module;
        _moduleResolver[_sName] = _name;
        _rModuleResolver[_name] = _sName;
        _isLoaded[_name] = false;
        _moduleByAddress[_module] = _name;
        _registeredAddress[_module] = true;
        _registeredName[_name] = true;
        _setModule(_module);
        emit ModuleRegistered(_module, _name);
    }

    function _setModule(address _module) internal {
        /*
    struct Module {
        bytes32 name;
        string version;
        string author;
        address contractAddr;
        bytes32 mHash;
    }
    */
        string memory ver = IModule(_module).moduleVersion();
        bytes32 author = IModule(_module).moduleAuthor();
        bytes32 mHash = IModule(_module).moduleHash();
        Module memory mod = Module(
            _moduleByAddress[_module],
            ver,
            author,
            _module,
            mHash
        );
        _modules[_moduleByAddress[_module]] = mod;
    }

    function deregisterModule(address _module) external {
        bytes32 _name = IModule(_module).moduleName();
        delete _moduleByName[_name];
        delete _isLoaded[_name];
        delete _moduleByAddress[_module];
        delete _registeredAddress[_module];
        delete _registeredName[_name];
        delete _modules[_name];
        delete _moduleResolver[_rModuleResolver[_name]];
        delete _rModuleResolver[_name];
        emit ModuleDeRegistered(_module);
    }

    function moduleName(address _module)
        external
        view
        override
        returns (bytes32)
    {
        return _moduleByAddress[_module];
    }

    function isRegisteredModuleAddress(address _module)
        external
        view
        returns (bool)
    {
        return _registeredAddress[_module] == true;
    }

    function isRegisteredModuleName(bytes32 _name)
        external
        view
        returns (bool)
    {
        return _registeredName[_name] == true;
    }

    function getModule(bytes32 _name) public view returns(Module memory) {
        return _modules[_name];
    }
}
