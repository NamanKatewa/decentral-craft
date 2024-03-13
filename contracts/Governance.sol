// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract Governance {
    address public owner;
    address[] public voterAddresses;
    mapping(address => bool) public voters;
    mapping(uint256 => mapping(address => bool)) public votes;
    mapping(uint256 => bool) public executedProposals;
    uint256 public proposalCount;
    uint256 public votingThreshold;

    event ProposalVoted(uint256 proposalId, address voter, bool inSupport);
    event ProposalExecuted(uint256 proposalId);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    constructor(uint256 _votingThreshold) {
        owner = msg.sender;
        voters[owner] = true;
        voterAddresses.push(owner);
        votingThreshold = _votingThreshold;
    }

    function addVoter(address newVoter) public onlyOwner {
        require(!voters[newVoter], "Already a voter");
        voters[newVoter] = true;
        voterAddresses.push(newVoter);
    }

    function submitProposal() public returns (uint256) {
        require(voters[msg.sender], "Not a voter");

        uint256 proposalId = proposalCount++;
        return proposalId;
    }

    function vote(uint256 proposalId, bool inSupport) public {
        require(voters[msg.sender], "Not a voter");
        require(!votes[proposalId][msg.sender], "Already voted");

        votes[proposalId][msg.sender] = true;

        emit ProposalVoted(proposalId, msg.sender, inSupport);

        if (shouldExecute(proposalId)) {
            executedProposals[proposalId] = true;
            emit ProposalExecuted(proposalId);
        }
    }

    function shouldExecute(uint256 proposalId) public view returns (bool) {
        require(proposalId < proposalCount, "Invalid proposal ID");

        uint256 supportCount = 0;
        uint256 totalVoters = voterAddresses.length;

        for (uint256 i = 0; i < totalVoters; i++) {
            address voter = voterAddresses[i];
            if (votes[proposalId][voter]) {
                supportCount++;
            }
        }

        uint256 supportPercentage = totalVoters > 0 ? (supportCount * 100) / totalVoters : 0;

        return supportPercentage >= votingThreshold;
    }
}