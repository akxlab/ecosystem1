interface IERC2055Decentralized {

    event Decentralized(address _deployer, address _decentralizedContract, uint256 timestamp);
    /**
    * @dev new function to ensure the decentralization of ERC2055 solving a long-running problem of ownership abuses
    * @dev this will allow for more transparency
    * Emits a {Decentralized} event.
    **/
    function decentralize(address _decentralizedContract) external returns(bool);

    function decentralizeAuto(address _decentralizedContract, uint256 _when) external;

    function verifyDecentralization(address _decentralizedContract) external returns(bool);

    function noTransferIfCentralized() external returns(bool);
    function noMintingIfCentralized() external returns(bool);
    function noBurningIfCentralized() external returns(bool);

    /**
    * @dev new function to ensure the decentralization of ERC2055
    * @dev will evaluate the called inteface id and deny them if they are true and not decentralized
    *
    **/
    function onlySupportsDecentralization(bytes4 interfaceId) external returns(bool);
}