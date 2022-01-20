var ArithmeticContract = artifacts.require("ArithmeticContract");
var StorageContract = artifacts.require("StorageContract");
var FunctionsContract = artifacts.require("FunctionsContract");
var PayableContract = artifacts.require("PayableContract");
var GlobalContrat = artifacts.require("GlobalContrat");

module.exports = function (deployer) {
    deployer.deploy(ArithmeticContract);
    deployer.deploy(StorageContract);
    deployer.deploy(FunctionsContract);
    deployer.deploy(PayableContract);
    deployer.deploy(GlobalContrat);
};
