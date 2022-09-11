// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "../modules/DidRegistry.sol";
import "../LabzERC2055/LabzERC2055.sol";
import "../modules/uds/UserDataServiceResolver.sol";

interface IAKX {

    
    function EthDIDRegistry() external returns(DidRegistry);
    function LabzToken() external returns(LabzERC2055);
    function UserDataService() external returns(UserDataServiceResolver);
    function DexToken(address token) external returns(IERC2055);






}