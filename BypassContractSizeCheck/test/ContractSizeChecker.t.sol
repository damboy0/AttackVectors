// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.0;

import {Test, console} from "../lib/forge-std/src/Test.sol";

import {Vm} from "../lib/forge-std/src/Vm.sol";


import {ContractSizeChecker } from "../src/ContractSizeChecker.sol";


contract EmptyContract {
    // This contract has no code, hence its code size is 0
}

contract ContractSizeCheckerTest is Test {
    
    ContractSizeChecker public target;

    function setUp() public {
        target = new ContractSizeChecker();
    }

    function testAttackSuccess() public {
        // Deploy an attacker contract that will call the attack function
        target.attack();

        // Check if the victim's tricked variable is set to true
        assertTrue(target.tricked(), "The attack should have succeeded");
    }
}