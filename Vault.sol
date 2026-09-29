// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Vault {
    address public owner;
    mapping(address => bool) public authorized;
    mapping(address => uint256) public balances;

    constructor() {
        owner = msg.sender;
        authorized[msg.sender] = true;
    }

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external {
        _send(payable(msg.sender), amount);
    }

    function withdrawTo(address payable to, uint256 amount) external {
        _send(to, amount);
    }

    function _send(address payable to, uint256 amount) internal {
        require(balances[msg.sender] >= amount, "insufficient balance");
        balances[msg.sender] -= amount;
        to.transfer(amount);
    }
}
