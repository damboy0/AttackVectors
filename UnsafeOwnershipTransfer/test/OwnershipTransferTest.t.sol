// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {OwnershipContract} from "../src/OwnershipContract.sol";


contract OwnershipTransferTest is Test {
    OwnershipContract public vulnerable;

    function setUp() public {
        vulnerable = new OwnershipContract();
        
    }

    function testTransferOwnership() public {

        vm.prank(address(0x123)); // Simulating a different user as the sender.
        vulnerable.transferOwnership(address(0x456)); // This should succeed due to lack of checks.
        
        assertEq(vulnerable.owner(), address(0x456), "Owner should have been changed to the attacker");
    }
}