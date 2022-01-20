pragma solidity ^0.8.0;

import "truffle/Assert.sol";
import "../contracts/FunctionsContract.sol";

contract TestFunctionsContract {

    FunctionsContract testFunctionContract = new FunctionsContract();

    function testViewFunction() public {
        Assert.equal(9, testFunctionContract.square(3), "It should be 9");
    }

    function testPureFunction() public {
        Assert.equal(5, testFunctionContract.getFive(), "It should be 9");
    }

}
