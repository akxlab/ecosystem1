// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@openzeppelin/contracts-upgradeable/proxy/beacon/IBeaconUpgradeable.sol";

contract PrivateSaleController is Initializable, IBeaconUpgradeable  {

    
    address public logicImplementation;

    constructor() {
        _disableInitializers();
    }

    function initialize(address impl_) public initializer {
        __PrivateSaleController_init(impl_);
    }

    function __PrivateSaleController_init(address impl_) public onlyInitializing {
        logicImplementation = impl_;
    }

      /**
     * @dev Must return an address that can be used as a delegate call target.
     *
     * {BeaconProxy} will check that this address is a contract.
     */
    function implementation() external view override returns (address) {
        return logicImplementation;
    }



    
}