// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract ProductDesignSubmission {
    struct DesignDetails {
        string name;
        string description;
        string imageUrl;
        string fileLink;
    }

    mapping(address => mapping(bytes32 => DesignDetails)) public designDetails;
    mapping(address => bytes32[]) public designHashes;

    function submitDesign(
        bytes32 designHash,
        string memory name,
        string memory description,
        string memory imageUrl,
        string memory fileLink
    ) public {
        require(bytes(designDetails[msg.sender][designHash].name).length ==0, "Design already submitted");

        designHashes[msg.sender].push(designHash);
        designDetails[msg.sender][designHash] = DesignDetails(name, description, imageUrl, fileLink);
    }

    function getDesignHashes(address designer) public view returns (bytes32[] memory) {
        return designHashes[designer];
    }

    function getDesignDetails(address designer, bytes32 designHash) public view returns (DesignDetails memory) {
        return designDetails[designer][designHash];
    }
}
