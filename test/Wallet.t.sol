// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import {Wallet}  from "../src/Wallet.sol";

contract WalletTest is Test {

    Wallet public wallet;

    function setUp() public {
        wallet = new Wallet();
    }


    function testSetOwner() public {
        wallet.setOwner(address(1));
        assertEq(wallet.owner(), address(1));
    }

    function testFailSetOwner() public {
        vm.prank(address(1));
        wallet.setOwner(address(1));
        assertEq(wallet.owner(), address(1));
    }
    

    function _send(uint256 amount) private {
        (bool ok,) = address(wallet).call{value:amount}("");
        require(ok,"send ETH Failed");
    }
    // Example of deal & hoax
    // deal(address,uint) => set balance of address
    // hoax(address,uint) => deal + prank, set up a prank and set balance

  function testEthBalance() public view {
    console.log("Eth Balance",address(this).balance / 1e18 );
  }


  function testSendETH() public {
    // deal
    deal(address(this),100);
    assertEq(address(this).balance,100, "test 1");

    deal(address(this),10);
    assertEq(address(this).balance,10, "test 2");


    deal(address(1),123);
    vm.prank(address(1));
    _send(123);


    // hoax => deal + prank;
    hoax(address(1),555);
    _send(555);
  }
    
}
