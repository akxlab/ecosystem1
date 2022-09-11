// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./IxToken.sol";

abstract contract xToken is IxToken {

    string private _xName;
    string private _xSymbol;
    uint256 private _xSupply;
    uint256 private _xPrice;

    address private _underlying;

    function tokenType() external override returns (string memory) {}

    function mintable() external override returns (bool) {}

    function burnable() external override returns (bool) {}


    function safeTransferToken(address to, uint256 amount) external override {
       /*  function transferToken(
        address token,
        address receiver,
        uint256 amount*/

        if(transferToken(_underlying, to, amount) != true) { 
            revert("XTOKEN: TRANSFER ERROR");
        }
        
    
    }

    function safeTransferToken(
        address from,
        address to,
        uint256 amount
    ) external override {
        transferToken(from, to, amount);
    }

    function lockToken(uint256 until) external override {}

    function unlockToken() external override {}

    function xTokenName() external view override returns (string memory) {
        return _xName;
    }

    function xTokenSymbol() external view override returns (string memory) {
        return _xSymbol;
    }

    function xTokenSupply() external view override returns (uint256) {
        return _xSupply;
    }

    function xTokenPrice() external view override returns (uint256) {
        return _xPrice;
    }

    function transferToken(
        address token,
        address receiver,
        uint256 amount
    ) internal returns (bool transferred) {
        // 0xa9059cbb - keccack("transfer(address,uint256)")
        bytes memory data = abi.encodeWithSelector(0xa9059cbb, receiver, amount);
        // solhint-disable-next-line no-inline-assembly
        assembly {
            // We write the return value to scratch space.
            // See https://docs.soliditylang.org/en/v0.7.6/internals/layout_in_memory.html#layout-in-memory
            let success := call(sub(gas(), 10000), token, 0, add(data, 0x20), mload(data), 0, 0x20)
            switch returndatasize()
                case 0 {
                    transferred := success
                }
                case 0x20 {
                    transferred := iszero(or(iszero(success), iszero(mload(0))))
                }
                default {
                    transferred := 0
                }
        }
    }
}

