// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;


interface IModule {
    event ModuleAdded(bytes32 _name);
    event ModuleRemoved(bytes32 _name);

    function moduleType() external returns(string memory);
    function moduleName() external returns(bytes32);
    function moduleVersion() external returns(string memory);
    function moduleAuthor() external returns(bytes32);
    function moduleHash() external returns(bytes32);
    function moduleContract() external returns(address);
    function compareVersions(string memory v1, string memory v2) external returns(bool);
    function loadModule(bytes32 _name, string memory version) external;

}