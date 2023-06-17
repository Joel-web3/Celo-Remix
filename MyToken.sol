// SPDX-License-Identifier: MIT

pragma solidity 0.8.15;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {

    uint256 public rate;

    event Buy(address indexed buyer, uint256 amount);
    event Withdraw(address indexed owner, uint256 amount);
        
    constructor() ERC20("Test Token", "TT") {
        rate = 100;
    }

    function buy() external payable {
        require(msg.value > 0);
        uint256 amount = msg.value * rate;
        _mint(msg.sender, amount);
        emit Buy(msg.sender, amount);
    }


    // Owner withdraw fund from token sale
    function withdraw() external onlyOwner {
        uint256 amount = address(this).balance;
        (bool status, ) = msg.sender.call{value:amount}("");
        require(status);
        emit Withdraw(msg.sender, amount);
    }
}
