pragma solidity ^0.8.0;

contract BaseContract {
    struct Client {
        string name;
        address account;
        uint money;
    }

    mapping(string => Client) clients;

    function newClient(string memory name) internal {
        clients[name] = Client(name, msg.sender, 0);
    }
}

contract ClientContract is BaseContract {
    function registerClient(string memory name) public{
        newClient(name);
    }

    function depositMoney(string memory name, uint amount) public {
        clients[name].money += amount;
    }

    function withdrawMoney(string memory name, uint amount) public returns (bool){
        if (clients[name].money < amount) {
            return false;
        }

        clients[name].money -= amount;
        return true;
    }
}
