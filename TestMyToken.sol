pragma solidity ^0.8.3;

import "remix_tests.sol";
import "../MyToken.sol";

contract TestMyToken {
    MyToken myToken;

    function beforeEach() public {
        myToken = new MyToken("MyToken", "MTK");
    }

    function checkNameAndSymbol() public {
        Assert.equal(myToken.name(), "MyToken", "Name should be MyToken");
        Assert.equal(myToken.symbol(), "MTK", "Symbol should be MTK");
    }

    function checkMinting() public {
        myToken.mint(address(this), 100);
        Assert.equal(myToken.balanceOf(address(this)), 100, "Balance should be 100");
        Assert.equal(myToken.totalSupply(), 100, "Total supply should be 100");
    }

    function checkTransfer() public {
        myToken.mint(address(this), 100);
        myToken.transfer(msg.sender, 50);
        Assert.equal(myToken.balanceOf(address(this)), 50, "Balance should be 50");
        Assert.equal(myToken.balanceOf(msg.sender), 50, "Recipient balance should be 50");
    }
}
