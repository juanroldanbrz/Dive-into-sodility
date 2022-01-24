pragma solidity ^0.8.0;

library Operations {

    function sub(uint i, uint j) public pure returns (uint){
        // Danger, it can be overflow if i < j;
        return i - j;
    }
}
