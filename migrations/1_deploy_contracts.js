var ArithmeticContract = artifacts.require("ArithmeticContract");
var StorageContract = artifacts.require("StorageContract");
var FunctionsContract = artifacts.require("FunctionsContract");
var PayableContract = artifacts.require("PayableContract");
var GlobalContrat = artifacts.require("GlobalContract");
var TimeContract = artifacts.require("TimeContract");
var HashContract = artifacts.require("HashContract");
var ElectionsContract = artifacts.require("ElectionsContract");

module.exports = function (deployer) {
    deployer.deploy(ArithmeticContract);
    deployer.deploy(StorageContract);
    deployer.deploy(FunctionsContract);
    deployer.deploy(PayableContract);
    deployer.deploy(GlobalContrat);
    deployer.deploy(TimeContract);
    deployer.deploy(HashContract);
    deployer.deploy(ElectionsContract);
};
