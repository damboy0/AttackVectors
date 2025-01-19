// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherBalance {
    uint256 public targetBalance = 10 ether;

    function checkBalance() public view returns (bool) {
        return address(this).balance == targetBalance;
    }

    function deposit() external payable {
        require(msg.value == 1 ether, "Must deposit exactly 1 ether");
    }
}
