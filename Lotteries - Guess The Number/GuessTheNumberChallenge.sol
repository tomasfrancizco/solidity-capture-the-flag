pragma solidity ^0.4.21;

contract GuessTheNumberChallenge {
    uint8 answer = 42;

    function GuessTheNumberChallenge() public payable {
        require(msg.value == 1 ether);
    }

    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function guess(uint8 n) public payable {
        require(msg.value == 1 ether);

        if (n == answer) {
            msg.sender.transfer(2 ether);
        }
    }
}

interface IGuessTheNumberChallenge {
    function guess(uint8 n) external payable;
}

contract GuessTheNumberSolver {
    IGuessTheNumberChallenge private challenge;
    address private owner;

    function Solver(address _challengeAddress) public {
        challenge = IGuessTheNumberChallenge(_challengeAddress);
        owner = msg.sender;
    }

    function attack(uint8 _answer) public payable {
        challenge.guess.value(1 ether)(_answer);
    }

    function withdraw() public {
        require(msg.sender == owner, "You must be the owner to withdraw funds");
        msg.sender.transfer(address(this).balance);
    }

    function() external payable {}
}