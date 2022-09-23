// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./utils/AdminUtils.sol";
import "./utils/DAOUtils.sol";
import "./utils/DaoProposals.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol";

contract AKXAdmin is
    Initializable,
    ContextUpgradeable,
    AdminUtils,
    DAOUtils,
    DAOProposalsUtils
{
    address public votingToken;
    address public akxDaoGovernor;

    constructor() {
        _disableInitializers();
    }

    function initialize() public initializer {}

    function __AKXAdmin_init() public onlyInitializing {
        __Context_init();
        __AdminUtils_init(msg.sender);
    }

    function setVotingToken(address _target) internal virtual override {
        votingToken = _target;
    }

    function addProposal(bytes4 proposalId) internal virtual override {}

    function updateProposal(bytes4 proposalId, bytes calldata _updated)
        external
        virtual
        override
    {}

    function approveNewProposalForVoting(address from, bytes4 proposalId)
        public
        virtual
        override
    {}

    function denyNewProposalForVoting(bytes4 proposalId)
        public
        virtual
        override
    {}

    function SubmitOtherProposal(
        uint256 timestampChangeShouldTakePlace,
        string memory additionalReasons,
        address contractToProposeOrExampleContract
    ) external virtual override {}
}