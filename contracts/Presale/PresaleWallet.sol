// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;


import "../utils/InitModifiers.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/finance/VestingWallet.sol";
import "../tokens/ERC2055/ERC2055.sol";

contract PresaleWallet is InitModifiers, Ownable, ReentrancyGuard, VestingWallet {


    uint256 public rewards;
    uint256 public rewardsReleased;
    uint256 public releasableRewards;
    uint256 public rewardsRate = 200000; // 2% of balance per days in LABZ
    address token;

    constructor(address beneficiary, address _token) VestingWallet(beneficiary, block.timestamp, 90 days) {
        token = _token;
    }

    function initPresaleWallet(address _owner) external onlyNotInitialized {
        transferOwnership(_owner);
    }


    function calculateRewards() public onlyOwner {
        uint256 balance = ERC2055(token).balanceOf(address(this));
        if(balance <= 0) {
            revert("cannot have rewards on no balance");
        }
        uint256 _reward = (balance * rewardsRate / 1e6) * (((block.timestamp - start())/ 1 days));
        rewards = _reward;
        releasableRewards = (rewards * (block.timestamp - start())) / duration();
    }

    function withdrawRewards() public payable onlyOwner {
        if(releasableRewards <= 0) {
            revert("no rewards yet! patience is a virtue");
        }
        ERC2055(token).safeTransferToken(address(this), beneficiary, releasableRewards);
    }

    function _vestingSchedule(uint256 totalAllocation, uint64 timestamp) internal view virtual returns (uint256) {
        if (timestamp < start()) {
            return 0;
        } else if (timestamp > start() + duration()) {
            return totalAllocation;
        } else {
            return (totalAllocation * (timestamp - start())) / duration();
        }
    }


}