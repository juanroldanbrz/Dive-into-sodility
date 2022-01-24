pragma solidity ^0.8.0;

contract EventsContract {
    event firstEvent(string personName);

    function emitFirstEvent(string memory personName) public {
        emit firstEvent(personName);
    }
}
