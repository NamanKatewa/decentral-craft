// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract FileStorage {
    mapping(bytes32 => bytes) private fileData;

    event FileUploaded(bytes32 indexed fileHash);

    function uploadFile(bytes32 fileHash, bytes memory data) external {
        require(fileData[fileHash].length == 0, "File already uploaded");

        fileData[fileHash] = data;

        emit FileUploaded(fileHash);
    }

    function getFile(bytes32 fileHash) external view returns (bytes memory) {
        require(fileData[fileHash].length > 0, "File not found");

        return fileData[fileHash];
    }
}
