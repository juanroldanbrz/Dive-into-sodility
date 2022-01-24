pragma solidity ^0.8.0;

contract ModifierContract {

    // Only the owner of the contract can run the function
    address public owner;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "Only the owner is allowed to perform this");
        _;
    }

    struct Client {
        address account;
        string name;
    }

    mapping(string => address) clients;

    function registerClient(string memory name) public {
        clients[name] = msg.sender;
    }

    modifier onlyClients(string memory name){
        require(clients[name] == msg.sender);
        _;
    }
}
