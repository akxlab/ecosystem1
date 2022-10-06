// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./Matrix.sol";
import "./Ledger.sol";

contract RootOfLife is Matrix, Ledger {


    address public hellKingdom;
    address public heavenKingdom;
    address public purgatory;

    

    constructor(string memory name_, string memory symbol_) Matrix(name_, symbol_) {

    }

    function findGodMolecule() public view returns(address) {
        return godMolecule;
    }




}