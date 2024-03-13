// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract QualityControl {
    mapping(bytes32 => bool) private passedQualityControl;

    event QualityControlPassed(bytes32 indexed designHash);

    function passQualityControl(bytes32 designHash) external {
        require(!passedQualityControl[designHash], "Design already passed quality control");

        passedQualityControl[designHash] = true;

        emit QualityControlPassed(designHash);
    }

    function hasPassedQualityControl(bytes32 designHash) external view returns (bool) {
        return passedQualityControl[designHash];
    }
}
