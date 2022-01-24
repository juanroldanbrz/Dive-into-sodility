pragma solidity ^0.8.0;

contract NgoContract {

    struct Ngo {
        uint id;
        string name;
        uint targetMoney;
        uint currentMoney;
    }

    uint nCauses = 0;
    mapping(string => Ngo) ngos;

    function newCause(string memory ngoName, uint targetMoney) public {
        nCauses += 1;
        ngos[ngoName] = Ngo(nCauses, ngoName, targetMoney, 0);
    }

    function isLimitReached(string memory ngoName, uint amount) private view returns (bool) {
        Ngo memory ngo = ngos[ngoName];
        return ngo.currentMoney + amount > ngo.targetMoney;
    }

    function donate(string memory ngoName, uint amount) public returns (bool) {
        if (isLimitReached(ngoName, amount)) {
            return false;
        }

        ngos[ngoName].currentMoney += amount;
        return true;
    }
}
