var ArithmeticContract = artifacts.require("ArithmeticContract");
var StorageContract = artifacts.require("StorageContract");
var FunctionsContract = artifacts.require("FunctionsContract");
var PayableContract = artifacts.require("PayableContract");
var GlobalContrat = artifacts.require("GlobalContract");
var TimeContract = artifacts.require("TimeContract");
var HashContract = artifacts.require("HashContract");
var ElectionsContract = artifacts.require("ElectionsContract");
var AmusementParkContract = artifacts.require("AmusementParkContract");

module.exports = function (deployer) {
    deployer.deploy(AmusementParkContract);
};
