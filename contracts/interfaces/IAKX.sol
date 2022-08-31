// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "./IUserRecord.sol";
import "./IModule.sol";
import "./IEIP721U.sol";
interface IAKX {

    enum Resolvers {
        UDS,
        DID,
        IDENT,
        METADATA,
        NAME,
        PROFILE
    }

    enum Registry {
        MODULES,
        DID,
        UDS,
        TX
    }

    event AKXEcosystemInitialized(address indexed rootResolver,
    address indexed initOwner, address dao, address labz, address dex);

    function getModule(bytes32 mName) external returns(IModule);

    function getResolver(Resolvers) external returns(address);

    function getRegistry(Registry) external returns(address);

    function getUser(uint256 tokenId) external returns(IEIP721U);

    function LabzToken() external returns(address);

    function PriceOracle() external returns(address);

    function Pools() external returns(address[] memory);

    function Controller(bytes32 cName) external returns(address);







}