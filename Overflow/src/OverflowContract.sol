// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract OverflowContract {
    uint8 public totalSupply;

    function add(uint8 value) public {
        unchecked {
            totalSupply += value; 
        }
    }
}
