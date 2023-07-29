// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "../src/Counter.sol";
import "forge-std/console.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
    }

    function testCount() public {
        console.log("Let deploy our contract");
        assertEq(counter.count(), 0);
    }

    function testInc() public {
        console.log("Testing the increment function");
        counter.inc();
        assertEq(counter.count(), 1);
    }

    function testDec() public {
        console.log("Testing the decrement function");
        // count will set to 1
        counter.inc();
        // count will set  2
        counter.inc();
        // count well decremented by 1
        counter.dec();
        assertEq(counter.count(), 1);
    }
}
