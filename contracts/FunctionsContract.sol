pragma solidity ^0.8.0;

contract FunctionsContract {

    uint state;

    constructor() {
        state = 0;
    }


    // Pure and view functions:

    // View function does not modify state
    function square(uint n) public view returns (uint){
        return n * n;
    }

    // Pure function does not modify or read state
    function getFive() public pure returns (uint){
        return 5;
    }

    // Public vs external.

    // External functions can be called within and outside the contract, but it has more gas fees.
    function publicFunction() public pure returns (uint){
        return 5;
    }

    // External functions cannot be called within the contract, but it has less gas fees.
    function externalFunction() external pure returns (uint){
        return 5;
    }
}
