//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "forge-std/Test.sol";

contract SignTest is Test {
    function TestSignature() public {
        uint256 privateKey = 678;
        address publicKey = vm.addr(privateKey);

        bytes32 messageHash = keccak256("I love You");

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, messageHash);

        address signer = ecrecover(messageHash, v, r, s);

        assertEq(signer, publicKey);
    }
}
