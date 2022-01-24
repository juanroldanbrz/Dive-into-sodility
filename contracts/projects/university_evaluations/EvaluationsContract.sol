pragma solidity ^0.8.0;

contract EvaluationsContract {

    address public teacherAddress;

    constructor(){
        teacherAddress = msg.sender;
    }

    mapping(bytes32 => uint) studentIdHashToEvaluations;

    string[] studentIdsWhoAskedForReview;

    event studentIsEvaluatedEvent(bytes32);
    event askedForReviewEvent(string);

    modifier onlyTeacher(){
        require(msg.sender == teacherAddress, "Only teacher can execute this call");
        _;
    }

    function evaluate(string memory studentId, uint score) public onlyTeacher {
        bytes32 studentIdHash = getHash(studentId);
        studentIdHashToEvaluations[studentIdHash] = score;
        emit studentIsEvaluatedEvent(studentIdHash);
    }

    function getAskedReviews() public view onlyTeacher returns (string[] memory reviews){
        return studentIdsWhoAskedForReview;
    }

    function checkEvaluations(string memory studentId) public view returns (uint){
        bytes32 studentIdHash = getHash(studentId);
        uint score = studentIdHashToEvaluations[studentIdHash];
        return score;
    }

    function askForReview(string memory studentId) public {
        studentIdsWhoAskedForReview.push(studentId);
        emit askedForReviewEvent(studentId);
    }

    function getHash(string memory variable) private pure returns (bytes32) {
        return keccak256(abi.encodePacked(variable));
    }
}
