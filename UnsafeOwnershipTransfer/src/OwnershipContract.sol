// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract OwnershipContract {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function transferOwnership(address newOwner) external {
        owner = newOwner; // No checking if msg.sender is the current owner.
    }
}
