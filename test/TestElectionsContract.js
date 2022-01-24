const ElectionsContract = artifacts.require("ElectionsContract");

//web3.utils.toWei('10', 'ether')
contract("ElectionsContract", accounts => {
    it("Owner should be able to register candidates", async () => {
        const instance = await ElectionsContract.deployed();
        await instance.registerCandidate("Juan", {from: accounts[0]});
        let event = await instance.getPastEvents('CandidateRegistered');
        assert.equal("Juan", event[0].args[0]);
        assert.equal(0, event[0].args[1].toNumber());

        await instance.registerCandidate("Peter");
        event = await instance.getPastEvents('CandidateRegistered');
        assert.equal("Peter", event[0].args[0]);
        assert.equal(1, event[0].args[1].toNumber());
    });
    it("User should not be able to register candidates", async () => {
        const instance = await ElectionsContract.deployed();
        instance.registerCandidate("Juan", {from: accounts[1]})
            .then(_ => fails())
            .catch(err => true)
    });
    it("User should be able to list candidates", async () => {
        const instance = await ElectionsContract.deployed();
        const candidates = await instance.listCandidates({from: accounts[1]});
        assert.equal("Juan", candidates[0]);
        assert.equal("Peter", candidates[1]);
    });
    it("User cannot vote unregistered candidate", async () => {
        const instance = await ElectionsContract.deployed();
        try {
            await instance.voteCandidate(3, {from: accounts[1]});
        } catch (err) {
            assert.include(err.message, "revert", "The error message should contain 'revert'");

        }
    });
    it("User cannot vote twice", async () => {
        const instance = await ElectionsContract.deployed();
        await instance.voteCandidate(1, {from: accounts[2]});
        try {
            await instance.voteCandidate(1, {from: accounts[2]})
            assert.fail("The transaction should have thrown an error");
        } catch (err) {
            assert.include(err.message, "revert", "The error message should contain 'revert'");
        }
    });
    it("User can list votes", async () => {
        const instance = await ElectionsContract.deployed();
        await instance.registerCandidate("Manolo", {from: accounts[0]});
        let event = await instance.getPastEvents('CandidateRegistered');
        const candidateId = event[0].args[1].toNumber();
        await instance.voteCandidate(candidateId, {from: accounts[3]});
        await instance.voteCandidate(candidateId, {from: accounts[4]});
        const votes = await instance.viewVotes(candidateId, {from: accounts[5]})
        assert.equal(2, votes.toNumber());
    });


});
