// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "../utils/DAOUtils.sol";


abstract contract LabzDAOProposalsV1 is DAOUtils {

  
    address public labzToken;

    mapping(address => mapping(bytes4 => uint256)) public proposalVotes;
    mapping(bytes4 => bool) public proposalIds;

    event ACCEPTED_PROPOSAL(bytes4 proposalId, uint256 numVotesYES, uint256 numVotesNO, uint256 numVotesAbstain, uint256 numVoters, uint256 timestamp, uint256 blockNumber, bytes data);


    constructor(address _dao)  {

    }


    function changeMaxSupply(uint256 newSupply) external onlyDAO() {

    }

    function upgradeTokenFeatures(string memory description,string memory additionalReasons, address upgradedContractProposed) external onlyDAO() {

    }

    function allowUpgrade(uint256 timestampChangeShouldTakePlace, string memory additionalReasons, address upgradedContractProposed) external onlyDAO() {

    }

    function changeTreasuryWallet(uint256 timestampChangeShouldTakePlace, string memory additionalReasons, address newTreasuryWallet) external onlyDAO() {

    }

    function changeMaxLimitPerWallet(uint256 timestampChangeShouldTakePlace, string memory additionalReasons, uint256 newLimit) external onlyDAO() {

    }

 

   

}