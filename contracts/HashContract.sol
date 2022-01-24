pragma solidity ^0.8.0;

contract HashContract {

    function calculateHash(string memory str) public pure returns (bytes32){
        return keccak256(abi.encodePacked(str));
    }

    function calculateHash(string memory str, uint number, address addr) public pure returns (bytes32){
        return keccak256(abi.encodePacked(str, number, addr));
    }
}
