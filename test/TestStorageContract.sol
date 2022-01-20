pragma solidity ^0.8.0;

import "truffle/Assert.sol";
import "../contracts/StorageContract.sol";

contract TestStorageContract {

    function testStorageContract() public {
        StorageContract storageContract = new StorageContract();
        storageContract.save("HelloWorld");

        Assert.equal("HelloWorld", storageContract.get(), "HelloWorld should be saved.");
    }
}
