// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AccessControl {
       address public owner;

    mapping(address => uint256) public balances;

    constructor() {
        owner = msg.sender;
    }

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdrawAll() external {
        uint256 balance = balances[msg.sender];
        require(balance > 0, "No funds to withdraw");
        balances[msg.sender] = 0;
        payable(msg.sender).transfer(balance);
    }

    function setOwner(address _newOwner) external {
        owner = _newOwner;
    }
}
