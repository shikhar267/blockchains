// SPDX-License-Identifier: MIT
pragma solidity ^0.4.0;

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
     
    struct OptionPos{
        uint pos;
        bool exists;
    }

    uint[] public votes;
    string[] public  options;
    mapping (address => bool) hasVoted;
    mapping (string => OptionPos) posOfOption;
    bool votingStarted;
    // constructor(string[] _options) {
    //     options = _options;
    //     votes.length = options.length;
    //     for(uint i=0;i< options.length;i++){
    //         OptionPos memory optionPos = OptionPos(i,true);
    //         string optionName = options[i];
    //         posOfOption[optionName] = optionPos;
    //     }
    // }

    function addOption(string option) public {
        require(!votingStarted);
        options.push(option);
    }

    function startVoting() public {
        require(!votingStarted);
        votes.length = options.length;

        for(uint i=0; i< options.length; i++){
            OptionPos memory option = OptionPos(i, true);
            posOfOption[options[i]] = option;
        }
        votingStarted = true;
    }
    function vote(uint option) public {
       require(0 <= option && option < options.length, "Invalid Option");
        require(!hasVoted[msg.sender],"Account has already voted");
        votes[option] = votes[option] + 1;
        hasVoted[msg.sender] = true;
    }

    function vote(string optionName) public {
        require(!hasVoted[msg.sender],"Account has already voted");
        OptionPos memory optionPos = posOfOption[optionName];
        require(optionPos.exists,"Option does not exists");
        votes[optionPos.pos] = votes[optionPos.pos] + 1;
        hasVoted[msg.sender] = true;
    }

    // function getOptions() public view returns (string[]){
    //     return options;
    // }

    function getVotes() public view returns (uint[]){
        return votes;
    }
}
