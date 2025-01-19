// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.0;

import {Test, console} from "../lib/forge-std/src/Test.sol";

import {LowLevelCall} from "../src/LowLevelCall.sol";

import {Vm} from "../lib/forge-std/src/Vm.sol";


contract LowLevelCallTest is Test {
    LowLevelCall public lowLevelCallContract ;

    address public attacker = address(0x1);


    function setUp() public {
        lowLevelCallContract = new LowLevelCall();

        vm.deal(attacker, 1 ether);
    }


    function testLowLevelCallToNonExistingAddress() public {
        vm.prank(attacker);

        address nonExistingAddressb = address(0x1234567890123456789012345678901234567890);
         bytes memory data = abi.encodeWithSignature("nonExistingFunc()");

         vm.expectRevert("Target address is not a contract");
         lowLevelCallContract.Call(nonExistingAddressb,data);

         vm.stopPrank();
    }

}