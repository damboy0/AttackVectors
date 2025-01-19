// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import {Test} from "../lib/forge-std/src/Test.sol";
import {OverflowContract} from "../src/OverflowContract.sol";

contract OverflowTest is Test {
    OverflowContract public vulnerable;

    function setUp() public {
        vulnerable = new OverflowContract();
    }

    function testOverflow() public {
        vulnerable.add(255);
        vulnerable.add(1);  

        
        assertEq(vulnerable.totalSupply(), 0, "Total supply should have overflowed to 0");
    }
}
