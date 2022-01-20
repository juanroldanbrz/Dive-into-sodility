const PayableContract = artifacts.require("PayableContract");

//web3.utils.toWei('10', 'ether')
contract("PayableContract", accounts => {
    it("Should buy 5 coins", async () => {
        const instance = await PayableContract.deployed();
        await instance.deposit(20, {value: 20});
        const bankBalance = await instance.getBankBalance();
        const coins = await instance.getCoins();
        assert.equal(bankBalance.toNumber(), 4, "100 wits should be bought");
        assert.equal(coins.toNumber(), 4, "20 coins should be bought");
    });
});
