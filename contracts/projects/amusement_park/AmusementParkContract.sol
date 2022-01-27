// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./AmusementTokenContract.sol";

contract AmusementParkContract {

    struct Client {
        uint nTokens;
        string[] rollerCoasters;
    }

    struct RollerCoaster {
        string name;
        uint tokenCost;
        bool isActive;
    }

    AmusementTokenContract private token;
    address private owner;
    mapping(address => Client) private clients;
    mapping(string => RollerCoaster) private rollerCoasters;
    string[] private rollerCoastersName;
    mapping(address => string[]) private clientRidesHistory;

    constructor(){
        token = new AmusementTokenContract(1000);
        owner = msg.sender;
    }

    function registerRollerCoaster(string memory name, uint tokens) external onlyOwner {
        RollerCoaster memory rollerCoaster = RollerCoaster(name, tokens, true);
        rollerCoasters[name] = rollerCoaster;
        rollerCoastersName.push(name);
        emit newRollerCoaster(name, tokens);
    }

    function removeRollerCoaster(string memory name) external onlyOwner {
        rollerCoasters[name].isActive = false;
        emit retiredRollerCoaster(name);
    }

    function availableRollerCoasters() external view returns (string[] memory){
        string[] memory toReturn = new string[](rollerCoastersName.length);
        for (uint i = 0; i < rollerCoastersName.length; i++) {
            if (rollerCoasters[rollerCoastersName[i]].isActive) {
                toReturn[i] = rollerCoastersName[i];
            }
        }
        return toReturn;
    }

    function getEthereumPrice(uint nTokens) internal pure returns (uint){
        return nTokens * 1 ether;
    }

    function buyTokens(uint nTokens) external payable {
        require(nTokens <= availableTokens(), "Not enough tokens to buy");
        uint cost = getEthereumPrice(nTokens);
        require(msg.value >= cost, "Not enough funds");
        uint change = msg.value - cost;
        payable(msg.sender).transfer(change);
        token.transfer(msg.sender, nTokens);
        clients[msg.sender].nTokens += nTokens;
    }

    function availableTokens() public view returns (uint){
        return token.balanceOf(address(this));
    }

    function rideRollerCoaster(string memory rollerCoasterName) external {
        require(rollerCoasters[rollerCoasterName].isActive, "Roller coaster is not active");
        uint requiredTokens = rollerCoasters[rollerCoasterName].tokenCost;
        require(requiredTokens <= token.balanceOf(msg.sender), "Not enough tokens");
        token.transferToContract(msg.sender, requiredTokens);
        clientRidesHistory[msg.sender].push(rollerCoasterName);
        emit rollerCoasterRide(rollerCoasterName, requiredTokens, msg.sender);
    }

    function balanceOf() public view returns (uint){
        return token.balanceOf(msg.sender);
    }

    function generateTokens(uint nTokens) external onlyOwner {
        token.increaseTotalSupply(nTokens);
    }

    function getOwner() external view returns (address) {
        return owner;
    }

    function getHistory() external view returns (string[] memory){
        return clientRidesHistory[msg.sender];
    }

    function returnTokens(uint nTokens) external {
        require(nTokens <= token.balanceOf(msg.sender), "Not enough tokens");
        token.transferToContract(msg.sender, nTokens);
        payable(msg.sender).send(nTokens * (getEthereumPrice()));
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "Only the owner can execute this function.");
        _;
    }

    event rollerCoasterRide(string, uint, address);
    event newRollerCoaster(string, uint);
    event retiredRollerCoaster(string);
}
