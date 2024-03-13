// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract DisputeResolution {
    enum DisputeResolutionStatus { Pending, Resolved }

    mapping(bytes32 => DisputeResolutionStatus) private disputeStatus;
    mapping(bytes32 => bool) private disputeRaised;

    event DisputeRaised(bytes32 indexed designHash);
    event DisputeResolved(bytes32 indexed designHash, bool resolution);

    function raiseDispute(bytes32 designHash) external {
        require(!disputeRaised[designHash], "Dispute already raised");
        disputeStatus[designHash] = DisputeResolutionStatus.Pending;
        disputeRaised[designHash] = true;

        emit DisputeRaised(designHash);
    }

    function resolveDispute(bytes32 designHash, bool resolution) external {
        require(disputeRaised[designHash], "No dispute raised");
        require(disputeStatus[designHash] == DisputeResolutionStatus.Pending, "Dispute already resolved");

        disputeStatus[designHash] = DisputeResolutionStatus.Resolved;

        emit DisputeResolved(designHash, resolution);
    }

    function getDisputeStatus(bytes32 designHash) external view returns (DisputeResolutionStatus) {
        return disputeStatus[designHash];
    }

    function hasDisputeBeenRaised(bytes32 designHash) external view returns (bool) {
        return disputeRaised[designHash];
    }
}