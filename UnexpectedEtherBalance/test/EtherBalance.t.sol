// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.0;

import {Test, console} from "../lib/forge-std/src/Test.sol";

import {EtherBalance} from "../src/EtherBalance.sol";
import {Vm} from "../lib/forge-std/src/Vm.sol";


contract BalanceTest is Test {
    EtherBalance public etherBalance; 
    address public attacker = address(0x1);


    function setUp() public{
        etherBalance = new EtherBalance();
        // vm.deal(address(etherBalance), 20 ether);
        vm.deal(attacker,20 ether);
    }
    
    function testDepositAndCheckBalance() public {
        // Attacker deposits 10 ether in total (1 ether each time)
        for (uint256 i = 0; i < 10; i++) {
            vm.prank(attacker);
            etherBalance.deposit{value: 1 ether}(); // Use prank to deposit
        }

        // Check if balance is correct after deposits
        assertTrue(etherBalance.checkBalance(), "Initial balance should be 10 ether");
    }

    function testDirectEtherTransfer() public {
        // Send ether directly to the contract without using deposit function
        (bool success, ) = address(etherBalance).call{value: 1 ether}("");
        
        // Now check if the balance check still works as expected
        bool result = etherBalance.checkBalance();

        // Assert that the balance check fails because we sent ether directly
        assertFalse(result, "Balance check should fail after direct transfer");
    }
}