// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;


import {Test, console} from "../lib/forge-std/src/Test.sol";
import {LoopingContract} from "../src/LoopingContract.sol";

contract LoopTest is Test {
    LoopingContract public vulnerable;

    function setUp() public {
        vulnerable = new LoopingContract();

    
        for (uint256 i = 0; i < 10000; i++) {
            vulnerable.addUser(address(uint160(i))); // Adding many users.
        }
    }

    function testGasLimit() public {
        
        vm.expectRevert();
        
        vulnerable.distributeFunds();
    }
}
