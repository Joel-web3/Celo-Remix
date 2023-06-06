// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract MyToken {
    mapping (address => uint256) private _balances;
    uint256 private _totalSupply;
    string private _name;
    string private _symbol;

    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

    function mint(address to, uint256 amount) public {
        _totalSupply += amount;
        _balances[to] += amount;
    }

    function transfer(address to, uint256 amount) public {
        require(_balances[msg.sender] >= amount, "Insufficient balance.");
        _balances[msg.sender] -= amount;
        _balances[to] += amount;
    }
}
