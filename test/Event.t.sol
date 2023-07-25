// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "../src/Event.sol";

contract EventTest is Test {
    Event public e;

    event Transfer(address indexed from, address indexed to, uint256 amoun);

    function setUp() public {
        e = new Event();
    }

    function testTransferEvent() public {
        // tell foundry which data to check
        vm.expectEmit(true, true, false, true);

        // emit the expected event
        emit Transfer(address(this), address(123), 250);

        // call the function that is expected to emit this event
        e.transfer(address(this), address(123), 250);
    }

    function testEmitManyTransfer() public {
        address[] memory to = new address[] (2);
        to[0] = address(123);
        to[1] = address(145);

        uint256[] memory amounts = new uint256[] (2);
        amounts[0] = 250;
        amounts[1] = 450;

        for (uint256 i = 0; i < to.length; i++) {
            vm.expectEmit(true, true, false, true);
            emit Transfer(address(this), to[i], amounts[i]);
            e.transferMany(address(this), to, amounts);
        }
    }
}
