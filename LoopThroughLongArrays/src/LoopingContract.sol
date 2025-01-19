// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LoopingContract {
    address[] public users;

    function addUser(address user) external {
        users.push(user);
    }

    function distributeFunds() external {
        for (uint256 i = 0; i < users.length; i++) {
            payable(users[i]).transfer(1 ether); // Can run out of gas if length is too large.
        }
    }
}
