// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "../modules/uds/UserDataServiceResolver.sol";



abstract contract BuyingLogic {

    mapping(address => bool) internal _hasAccount;
    mapping(address => uint256) internal _userTokens;

    UserDataServiceResolver _uds;

    constructor(address stabilizer, int256 labzToUSD) {

    }

    function _beforeLogic(address _sender) internal {
        if(_hasAccount[_sender] == false) {
            uint256 ___id = _uds.createNewAccount(_sender, "");
            _hasAccount[_sender] = true;
            _userTokens[_sender] = ___id;
        }
    }

    function _startLogic(address _sender, uint256 _amountSent, bool isVip) internal {
        _beforeLogic(_sender);
        if(isVip == true) {
            _addMetasToNFT(_userTokens[_sender], "VIP", abi.encode(1));
        }
    }


    //function setMetaData(uint256 tokenId, string memory keyStr, uint _dtype, bytes memory value, bool editable, bool encrypted) external
    function _addMetasToNFT(uint256 _tid, string memory key, bytes memory value) internal {
        _uds.setMetaData(_tid, key,  0, value, false, false);
    }

}