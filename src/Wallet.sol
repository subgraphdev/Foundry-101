// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

contract Wallet {
    address payable public owner;

    event Deposit(address account,uint256 amount);

    constructor() payable {
        owner = payable(msg.sender);
    }

    function withdraw(uint256 _amount) external {
        require(msg.sender == owner, "caller is not an onwer");
        payable(msg.sender).transfer(_amount);
    }

    function setOwner(address _owner) external {
        require(msg.sender == owner, "caller is not an onwer");
        owner = payable(_owner);
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }
}
