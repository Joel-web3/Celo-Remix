// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "remix_tests.sol"; 
import "../Counter.sol";

contract TestCounter {
    Counter counter;

    function beforeEach() public {
        counter = new Counter();
    }

    function checkInc() public {
        counter.inc();
        Assert.equal(counter.count(), 1, "Count should be 1 after inc");
    }

    function checkDec() public {
        counter.inc();
        counter.dec();
        Assert.equal(counter.count(), 0, "Count should be 0 after inc and dec");
    }
}