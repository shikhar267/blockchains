// SPDX-License-Identifier: MIT
pragma solidity ^0.4.0;
pragma experimental ABIEncoderV2;

//["coffee","tea"]
// solidity has oone global object that is 'msg' that contains inform that sent to our smart contract
// msg.sender;
// msg.value number of ether send
// msg.data complete ttransation data (encoded arugement method call)
// msg.sig //numerail identifier of the funtion 
// msg.gas //depricated
// version support 0.4.26

// mapping ((key-type) => [value-type]) mapName;
// get toal number of keys, check if the key exists, get all keys---- not allowed
 contract Voter {
    uint[] public votes;
    string[] public  options;
    mapping (address => bool) hasVoted;

    constructor(string[] _options) {
        options = _options;
        votes.length = options.length;
    }
    function vote(uint option) public {
       require(0 <= option && option < options.length, "Invalid Option");
        require(!hasVoted[msg.sender],"Account has already voted");
        votes[option] = votes[option] + 1;
        hasVoted[msg.sender] = true;
    }
    function getOptions() public view returns (string[]){
        return options;
    }

    function getVotes() public view returns (uint[]){
        return votes;
    }
}
