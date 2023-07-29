//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";
import {Sign}  from "../src/Sign.sol";


contract SignTest is Test {
    Sign public sign;
    function setUp() public {
        sign = new Sign();
    }

    
    function TestSignature() public {
        uint256 privateKey = 678;
        address publicKey = vm.addr(privateKey);

        bytes32 messageHash = keccak256("I love You");

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, messageHash);

        address signer = ecrecover(messageHash, v, r, s);

        assertEq(signer, publicKey);
    }
}
