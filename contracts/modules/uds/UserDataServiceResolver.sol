// SPDX-License-Identifier: MIT
pragma solidity 0.8.16;

import "../../resolvers/AllResolvers.sol";
import "./UDS.sol";

contract UserDataServiceResolver is AllResolvers {
    UDS uds;

        /**
     * A mapping of authorisations. An address that is authorised for a profile name
     * may make any changes to the name that the owner could, but may not update
     * the set of authorisations.
     * (node, owner, caller) => isAuthorised
     */
    mapping(bytes32=>mapping(address=>mapping(address=>bool))) public authorisations;
    event AuthorisationChanged(bytes32 indexed profileId, address indexed owner, address indexed target, bool isAuthorised);

    constructor(UDS _uds) {
        uds = _uds;
    }

     function setAuthorisation(bytes32 profileId, address target, bool isAuthorised) external {
        authorisations[profileId][msg.sender][target] = isAuthorised;
        emit AuthorisationChanged(profileId, msg.sender, target, isAuthorised);
    }

    function isAuthorised(bytes32 profileId) internal  view returns(bool) {
        address owner = uds.owner(profileId);
        return owner == msg.sender || authorisations[profileId][owner][msg.sender];
    }


    function multicall(bytes[] calldata data) external returns(bytes[] memory results) {
        results = new bytes[](data.length);
        for(uint i = 0; i < data.length; i++) {
            (bool success, bytes memory result) = address(this).delegatecall(data[i]);
            require(success);
            results[i] = result;
        }
        return results;
    }

}