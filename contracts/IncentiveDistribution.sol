// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract IncentiveDistribution {
    mapping(address => uint256) public earnedIncentives;
    mapping(address => bool) public claimedIncentives;

    event IncentivesDistributed(address indexed contributor, uint256 amount);
    event IncentivesClaimed(address indexed contributor, uint256 amount);

    function distributeIncentives(address contributor, uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");
        require(!claimedIncentives[contributor], "Incentives already claimed");

        earnedIncentives[contributor] += amount;

        emit IncentivesDistributed(contributor, amount);
    }

    function claimIncentives() external {
        require(earnedIncentives[msg.sender] > 0, "No incentives to claim");
        require(!claimedIncentives[msg.sender], "Incentives already claimed");

        uint256 amountToClaim = earnedIncentives[msg.sender];
        claimedIncentives[msg.sender] = true;

        emit IncentivesClaimed(msg.sender, amountToClaim);
    }
}
