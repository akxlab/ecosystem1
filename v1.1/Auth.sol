// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./interfaces/IAuth.sol";
import "./modules/uds/UserDataServiceResolver.sol";

abstract contract Auth is IAuth {

  uint256 maxTry;
  uint256 tempBanDuration;
  error AuthenticationFailed();
    error InvalidAddress();
    error MaxTryReach();


  mapping(address => uint256) private _numTry;
  mapping(address => bool) private _tryBan;
  mapping(address => uint256) private _unbannedOnTime;
  mapping(address => bool) private _noBanWhiteList;
  mapping(address => bool) private _authenticated;



    /**
     * authenticate(address)
     * @notice implements IAuth interface authenticate function and perform authentication logic
     * @dev flow : we check if the user exists
     * @dev flow : we check if the user is banned
     * @dev flow : user is authenticated and emits the Authenticated event for the backend
     * @param _udsr we link to the UserDataServiceResolver contract to check if the user exists
     */
  function authenticate(address _udsr) external override returns(bool) {
    require(msg.sender != address(0), "no zero address");
    if(_authenticated[msg.sender] != true) {
    _checkUser(msg.sender, UserDataServiceResolver(_udsr)); // if user does not exists it will revert
    // @dev its ok we got the user time to check if our user is having enough attempts left
    addTry(msg.sender);
    

    // @dev yess it does! now we will authenticate it
    UserDataServiceResolver.AccountInfo memory __info = UserDataServiceResolver(_udsr).getAccountInfo(msg.sender);
    
    setAuthenticated(msg.sender, abi.encode(__info));
    return true;
    } else if(_authenticated[msg.sender] == true) {
        return true;
    }
    revert AuthenticationFailed();


  }

  function _checkUser(address _user, UserDataServiceResolver udsr) internal virtual {
    if(!udsr.alreadyRegistered(_user)) {
        revert InvalidAddress();
    }
  }


    function setAuthenticated(address _user, bytes memory data) internal virtual  {
        _authenticated[_user] = true;
        _numTry[_user] = 0;
        emit Authenticated(_user, true, data);
    }

    function disconnect() external returns(bool) {
        _authenticated[msg.sender] = false;
        return true;
      
    }

    function setMaxTry() internal {
        maxTry = 4;
    }

    function setTempBanDuration() internal {
        tempBanDuration = 15 * 1 minutes; // 15 min
    }

    /**
     * addTry(address)
     * @notice increments the number of fail attempts a user is allowed to make (max 4)
     * @notice if the number is higher or equal it will revert saying user has reached the maximum number of attempts
     * @notice it will then put it on the temporary banlist and make him wait 15 minute to reset the number of attempts to zero
     * @param _owner the address for which we add the attempt
     */
    function addTry(address _owner) internal {
        // @dev always fail early ! 
         if(_numTry[_owner] >= maxTry && _noBanWhiteList[_owner] != true) {
            _tryBan[_owner] = true;
            revert MaxTryReach();
        } 
        if(_tryBan[_owner] == true) {
            unbanUser(_owner); // we try to unban the user if we cant it will revert
        }
        if(_numTry[_owner] > 0) {
        _numTry[_owner] += 1;
        } else {
            _numTry[_owner] = 1;
        }
        emit Authenticating(_owner);
    }

    function setBanTimeForUser(address _owner) internal {
        _unbannedOnTime[_owner] = block.timestamp + tempBanDuration; // set ban time to 15 minutes after now
    }

    function unbanUser(address _owner) internal {
        if(_unbannedOnTime[_owner] < block.timestamp) {
            revert MaxTryReach();
        }
        delete _tryBan[_owner];
        delete _unbannedOnTime[_owner];
    }

    function _addToNoBanWhitelist(address _owner) internal virtual {
        if(_noBanWhiteList[_owner] != true) {
            _noBanWhiteList[_owner] = true;
            emit AddedToNoBanWLEvent(_owner);
        }
    }


}