// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

abstract contract AKXSetup {
    address internal ethrDidRegistry;
    address internal labzToken;
    address internal userDataService;
    address internal dexService;
    address internal daoGovernor;
    address internal akxToken; // vote enabled token

    function _setEthrDid(address _did) internal virtual {
        ethrDidRegistry = _did;
    }

    function _setLabzToken(address _tok) internal virtual {
        labzToken = _tok;
    }

    function _setUDS(address _uds) internal virtual {
        userDataService = _uds;
    }

    function _setDEX(address _dex) internal virtual {
        dexService = _dex;
    }

    function _setGov(address _gov) internal virtual {
        daoGovernor = _gov;
    }

    function _setAkxToken(address _akx) internal virtual {
        akxToken = _akx;
    }
}