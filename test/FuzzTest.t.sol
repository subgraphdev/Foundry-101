//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import {Safe} from "../src/Fuzz.sol";

contract SafeTest is Test {
    Safe public safe;

    // Needed so the test contract itself can receive ether
    // when withdrawing
    receive() external payable {}

    function setUp() public {
        safe = new Safe();
    }

    /* This unit test does test that we can withdraw ether from our safe.
      However, who is to say that it works for all amounts, not just 1 ether?
    */

    function test_Withdraw() public {
        payable(address(safe)).transfer(1 ether);
        uint256 preBalance = address(this).balance;
        safe.withdraw();
        uint256 postBalance = address(this).balance;
        assertEq(preBalance + 1 ether, postBalance);
    }

    ///////////////////////////////// 
    /// Fuzz Testing       ////
    /////////////////////////////////

    // Forge will run any test that takes at least one parameter as a property-based test,
    //The default amount of ether that the test contract is given is 2**96 wei (as in DappTools),
    //so we have to restrict the type of amount to uint96 to make sure we don't try to send more than we have:

    //You might have noticed that fuzz tests are summarized a bit differently compared to unit tests:

    /*
    "runs" refers to the amount of scenarios the fuzzer tested. By default, 
    the fuzzer will generate 256 scenarios, but this and other test execution parameters 
    can be setup by the user. Fuzzer configuration details are provided here.
    "μ" (Greek letter mu) is the mean gas used across all fuzz runs
    "~" (tilde) is the median gas used across all fuzz runs
    */

    function testAssumeFuzz_Withdraw(uint96 amount) public {
        //Wemay want to exclude certain cases using the assume cheatcode.
        // In those cases, fuzzer will discard the inputs and start a new fuzz run:
        vm.assume(amount > 0.1 ether);
        //amount = vm.bound(amount,0.1 ether,1 ether);
        payable(address(safe)).transfer(amount);
        uint256 preBalance = address(this).balance;
        safe.withdraw();
        uint256 postBalance = address(this).balance;
        assertEq(preBalance + amount, postBalance);
    }

}
