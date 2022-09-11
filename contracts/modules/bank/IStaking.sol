// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IStaking {
    struct StakingData {
        uint256 amountStaked;
        uint256 totalRewards;
        uint256 claimedRewards;
        uint256 claimable;
        uint256 stakedSince;
        uint256 rewardsPerHour;
        address rewardToken;
    }
}