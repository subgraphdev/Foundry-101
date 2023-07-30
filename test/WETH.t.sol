//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


import "forge-std/Test.sol";
import {WETH} from "../src/WETH.sol";

contract WethTest is Test {
    WETH public weth;

    function setUp() public {
    weth = new WETH();
    }

    function invariant_totalSupply_is_always_zero() public {
        assertEq(weth.totalSupply(),0);
    }
}