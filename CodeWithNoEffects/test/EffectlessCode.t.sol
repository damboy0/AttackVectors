// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.0;

import {Test, console} from "../lib/forge-std/src/Test.sol";

import {Vm} from "../lib/forge-std/src/Vm.sol";

import {EffectlessCode} from "../src/EffectlessCode.sol";

contract EffectlessCodeTest is Test {
    EffectlessCode public effectlessCodeContract;

    address public person = address(0x1);


    function setUp() public {
        effectlessCodeContract = new EffectlessCode();

        vm.deal(person, 1 ether);
    }


    function testSendEtherError() public {

        uint256 initialBalance = person.balance;
        vm.prank(person);

        effectlessCodeContract.sendEther{value: 1 ether};

        uint256 finalBalance = person.balance;

        assertEq(initialBalance,finalBalance,"Ether is not supposed to be transferred");

        vm.stopPrank();

    }
}