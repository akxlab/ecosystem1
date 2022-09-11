// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

abstract contract Modifiers {

   modifier onlyGateway(address _sender) {
        if(type(_sender).interfaceId == "AKXGateway")
    }

}