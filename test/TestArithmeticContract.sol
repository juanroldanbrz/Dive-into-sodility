pragma solidity ^0.8.0;

import "truffle/Assert.sol";
import "../contracts/ArithmeticContract.sol";

contract TestArithmeticContract {

    function testArithmeticContract() public {
        ArithmeticContract arithmeticContract = new ArithmeticContract();
        uint result = arithmeticContract.sum(1, 2);

        Assert.equal(3, result, "Sum should be 3");
    }
}
