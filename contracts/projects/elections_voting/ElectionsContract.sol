pragma solidity ^0.8.0;

contract ElectionsContract {

    address private owner;

    struct Candidate {
        uint id;
        string name;
    }

    constructor(){
        owner = msg.sender;
    }

    mapping(uint => Candidate) candidateIdToCandidate;
    mapping(uint => uint) candidateIdToVotes;
    mapping(address => bool) hasUserVoted;
    mapping(uint => bool) isCandidateRegistered;

    Candidate[] candidates;

    event CandidateRegistered(string name, uint id);

    function registerCandidate(string memory name) public {
        require(msg.sender == owner, "Only owner can register candidates");
        uint candidateId = candidates.length;
        Candidate memory candidate = Candidate(candidateId, name);
        candidates.push(candidate);
        isCandidateRegistered[candidateId] = true;
        candidateIdToCandidate[candidateId] = candidate;
        emit CandidateRegistered(name, candidateId);
    }

    function listCandidates() public view returns (string[] memory) {
        string[] memory candidatesNames = new string[](candidates.length);
        for (uint i = 0; i < candidates.length; i++) {
            candidatesNames[i] = candidates[i].name;
        }
        return candidatesNames;
    }

    function voteCandidate(uint candidateId) public {
        require(hasUserVoted[msg.sender] == false, "You can only vote once");
        require(isCandidateRegistered[candidateId] == true, "Candidate is not registered");
        candidateIdToVotes[candidateId] += 1;
        hasUserVoted[msg.sender] = true;
    }

    function viewVotes(uint candidateId) public view returns (uint){
        require(isCandidateRegistered[candidateId] == true, "Candidate is not registered");
        return candidateIdToVotes[candidateId];
    }

    function getWinner() public view returns (string memory, uint){
        string memory candidateMaxVotesName = "";
        int candidateMaxVote = - 1;
        for (uint i = 0; i < candidates.length; i++) {
            uint candidateId = candidates[i].id;
            uint votes = viewVotes(candidateId);
            if (int(votes) > candidateMaxVote) {
                candidateMaxVote = int(votes);
                candidateMaxVotesName = candidates[i].name;
            }
        }
        return (candidateMaxVotesName, uint(candidateMaxVote));
    }
}
