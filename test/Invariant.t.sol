//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


import "forge-std/Test.sol";
import {Invariant} from "../src/Invariant.sol";


contract InvariantTest is Test {

    Invariant public invariant;

    function setUp() public {
        invariant = new Invariant();
    }

    function invariant_FlagIsAlwaysFalse() public {
        assertEq(invariant.flag(), false);
    }

}