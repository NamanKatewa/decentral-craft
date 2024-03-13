// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract UserIdentity {
    mapping(address => string) private usernames;
    mapping(address => string) private roles;

    event UserNameSet(address indexed user, string username);
    event UserRoleSet(address indexed user, string role);

    function setUserName(string memory username) external {
        require(bytes(usernames[msg.sender]).length == 0, "Username already set");

        usernames[msg.sender] = username;

        emit UserNameSet(msg.sender, username);
    }

    function setUserRole(string memory role) external {
        require(bytes(roles[msg.sender]).length == 0, "Role already set");

        roles[msg.sender] = role;

        emit UserRoleSet(msg.sender, role);
    }

    function getUserName(address user) external view returns (string memory) {
        return usernames[user];
    }

    function getUserRole(address user) external view returns (string memory) {
        return roles[user];
    }
}