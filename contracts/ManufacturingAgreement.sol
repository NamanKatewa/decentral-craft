// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract ManufacturingAgreement {
    mapping(bytes32 => mapping(address => bool)) public agreements;

    function agreeToManufacture(bytes32 designHash) public{
        require( !agreements[designHash][msg.sender], "Already agreed to manufacture");

        agreements[designHash][msg.sender] = true;
    }

    function hasAgreement(bytes32 designHash, address manufacturer) public view returns (bool){
        return agreements[designHash][manufacturer];
    }
}