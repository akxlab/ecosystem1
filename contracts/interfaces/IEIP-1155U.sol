// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

    /**
     * @title ETHEREUM IMPROVEMENTS PROPOSAL draftEIP-1155U Derivated from IERC1155
     * @notice Suggested preliminary standard for non fungible user token or SBT-like token
     */

interface IEIP1155U {

    event UserMinted(address indexed operator, address indexed owner, bytes32 id);
    event UserBurned(address indexed operator, bytes32 id);
    event UserRecovered(address indexed operator, address indexed by, bytes32 id);
    event URI(string _value, uint256 indexed _id);

/**
        @dev Either `TransferSingle` or `TransferBatch` MUST emit when tokens are transferred, including zero value transfers as well as minting or burning (see "Safe Transfer Rules" section of the standard).
        The `_operator` argument MUST be the address of an account/contract that is approved to make the transfer (SHOULD be msg.sender).
        The `_from` argument MUST be the address of the holder whose balance is decreased.
        The `_to` argument MUST be the address of the recipient whose balance is increased.
        The `_id` argument MUST be the token type being transferred.
        When minting/creating tokens, the `_from` argument MUST be set to `0x0` (i.e. zero address).
        When burning/destroying tokens, the `_to` argument MUST be set to `0x0` (i.e. zero address).        
    */
    event TransferSingle(address indexed _operator, address indexed _from, address indexed _to, uint256 _id);

    /**
        @dev Either `TransferSingle` or `TransferBatch` MUST emit when tokens are transferred, including zero value transfers as well as minting or burning (see "Safe Transfer Rules" section of the standard).      
        The `_operator` argument MUST be the address of an account/contract that is approved to make the transfer (SHOULD be msg.sender).
        The `_from` argument MUST be the address of the holder whose balance is decreased.
        The `_to` argument MUST be the address of the recipient whose balance is increased.
        The `_values` argument MUST be the list of number of tokens (matching the list and order of tokens specified in _ids) the holder balance is decreased by and match what the recipient balance is increased by.
        When minting/creating tokens, the `_from` argument MUST be set to `0x0` (i.e. zero address).
        When burning/destroying tokens, the `_to` argument MUST be set to `0x0` (i.e. zero address).                
    */
    event TransferBatch(address indexed _operator, address indexed _from, address indexed _to, uint256[] _ids);

    /**
        @dev MUST emit when approval for a second party/operator address to manage all tokens for an owner address is enabled or disabled (absence of an event assumes disabled).        
    */
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);



    /**
        @notice Transfers users to another entity per example a company or project is sold to another entity allows transfering its users ownership
        @dev Caller must be approved to manage the tokens being transferred out of the `_from` account (see "Approval" section of the standard).
        MUST revert if `_to` is the zero address or same as original owner.
        MUST revert if balance of holder for token `_id` is lower than the `_value` sent.
        MUST revert on any other error.
        MUST emit the `TransferSingle` event to reflect the balance change (see "Safe Transfer Rules" section of the standard).
        After the above conditions are met, this function MUST check if `_to` is a smart contract (e.g. code size > 0). If so, it MUST call `onERC1155Received` on `_to` and act appropriately (see "Safe Transfer Rules" section of the standard).        
        @param _from    Source address
        @param _to      Target address
        @param _id each user is having a verification hash to prove its creation (externally verified)
        @param _data    Additional data with no specified format, MUST be sent unaltered in call to `onERC1155Received` on `_to`
    */
    function safeTransferFrom(address _from, address _to, uint256 _id, bytes memory _data) external;
    
    /**
     * @notice same as SafeTransferFrom but for batches. Transfers many users to another entity
     */
    function safeBatchTransferFrom(address _from, address _to, uint256[] calldata _ids, bytes calldata _data) external;

    /**
     * @notice we void the balanceOf function of ERC1155 as it has no purpose here
     */
    function balanceOf(address _owner, uint256 _id) external;

    /**
        @notice Enable or disable approval for a third party ("operator") to manage all of the caller's tokens.
        @dev MUST emit the ApprovalForAll event on success.
        @param _operator  Address to add to the set of authorized operators
        @param _approved  True if the operator is approved, false to revoke approval
    */
    function setApprovalForAll(address _operator, bool _approved) external;

     /**
        @notice Queries the approval status of an operator for a given owner.
        @param _owner     The owner of the tokens
        @param _operator  Address of authorized operator
        @return           True if the operator is approved, false if not
    */
    function isApprovedForAll(address _owner, address _operator) external view returns (bool);

    /**
     * @notice Mints the user nft token
     * @dev MUST emit UserMinted event on success
     * @param _to mint to the owner of the user (first requester)
     */
    function mint(address _to) external returns(uint256);

      /**
     * @notice Burns the user nft token (delete user)
     * @dev MUST emit UserBurned event on success
     * @param _to user cemetary address (burned users or souls are dead but recoverable in case of wrongly deleting them)
     * @param _from the burn must come from an approved operator only
     * @return will return burn op id in case we need to recover the deletion operation
     */
    function burn(address _from, address _to) external returns(uint256);


      /**
     * @notice Recovery mechanism if user is losing access to its account
     * @dev MUST emit UserRecovered event on success
     * @param _from the burn must come from an approved operator only
     * @param _recoveryData to be implemented (zk proof?)
     */
    function recover(address _from, bytes calldata _recoveryData) external returns(bool);


}