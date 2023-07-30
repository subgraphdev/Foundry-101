//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Invariant {
    bool public flag;

    function func_1() external {}
    function func_2() external {}
    function func_3() external {}
    function func_4() external{}
    function func_5() external {
        flag = true;
    }
}
