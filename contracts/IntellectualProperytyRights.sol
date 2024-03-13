// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract IntellectualPropertyRights{
    mapping(bytes32 => address) public owners;

    function claimOwnership(bytes32 designHash) public {
        require(owners[designHash] == address(0), "Design already claimed");
        owners[designHash] = msg.sender;
    }

    function getOwner(bytes32 designHash) public view returns (address) {
        return owners[designHash];
    }
}
