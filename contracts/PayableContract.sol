pragma solidity ^0.8.0;

contract PayableContract {

    uint coinPrice = 5 wei;
    mapping(address => uint) accounts;
    uint soldCoins;

    constructor() {
        soldCoins = 0;
    }

    function deposit(uint256 amount) payable public {
        require(msg.value == amount);
        accounts[msg.sender] = amount / coinPrice;
        // nothing else to do!
    }

    function getBankBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function getCoins() public view returns (uint256) {
        return accounts[msg.sender];
    }
}
