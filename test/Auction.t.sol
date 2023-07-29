//SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import "../src/Auction.sol";

contract TestAuction is Test {
    // vm.warp() - set block.timestamp to future timestamp
    // vm.roll - set block.number
    // skip - increment current timestamp
    // rewind - decrement current timestamp

    Auction public auction;
    uint256 private startAt;

    function setUp() public {
        auction = new Auction();
        startAt = block.timestamp;
    }

    function testBidFail() public {
        vm.expectRevert(bytes("Cannot Bid"));
        auction.bid();
    }

    function testBid() public {
        vm.warp(startAt + 1 days);
        auction.bid();
    }

    function testBidFailAfterEnd() public {
        vm.warp(startAt + 2 days);
        vm.expectRevert(bytes("Cannot Bid"));
        auction.bid();
    }

    function testTimestamp() public {
        // skip - increment the current timestamp
        uint256 t = block.timestamp;

        skip(100);

        assertEq(block.timestamp, t + 100);

        // rewind - decrement the current timestamp
        rewind(10);
        assertEq(block.timestamp, t + 100 - 10);
    }

    function testBlockNumber() public {
        uint256 b = block.number;
        vm.roll(999);
        assertEq(block.number, 999);
    }
}
