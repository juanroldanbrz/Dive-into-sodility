pragma solidity ^0.8.0;

contract GlobalContract {

    function getMessageSender() public view returns (address){
        return msg.sender;
    }

    function getTimestamp() public view returns (uint){
        return block.timestamp;
    }

    function getMinerAddress() public view returns (address){
        return block.coinbase;
    }

    function getBlockDifficulty() public view returns (uint){
        return block.difficulty;
    }

    function getBlockNumber() public view returns (uint){
        return block.number;
    }

    function getMessageSignature() public pure returns (bytes4){
        return msg.sig;
    }

    function getTxGasPriceLeft() public view returns (uint){
        return tx.gasprice;
    }
}