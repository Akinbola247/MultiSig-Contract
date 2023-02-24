// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract multiSig {
    address[] Admins;

    constructor(address[] memory _admins) {
        require(_admins.length >= 3, "minimum admins not met");
        for(uint i = 0; i < _admins.length; i++){
            adminStatus[_admins[i]] = true;
        }
        Admins = _admins;
    }

modifier onlyAdmins (address caller) {
    bool valid;
    for (uint i = 0; i  < Admins.length; i++){
        if (caller == Admins[i]){
            valid = true;
            break;
        }
    }
    require(valid, "not an admin");
    _;
}
    mapping (address => bool) adminStatus;
    mapping(address => mapping(address => bool)) voteStatus;
    mapping(address => uint) voteCount;
    
    function addAdmin(address _newAdmin) external onlyAdmins(msg.sender) {
        uint voteCal = calVote();
        require(_newAdmin != address(0), "zero address cannot be added");
        require(adminStatus[_newAdmin] == false, "already an admin");
        require(voteCount[_newAdmin] > voteCal, "Total number did not agree");   
        Admins.push(_newAdmin);
        adminStatus[_newAdmin] = true;
        voteCount[_newAdmin] = 0;
    }
   
    function vote(address _voted) external onlyAdmins(msg.sender){
        require(voteStatus[msg.sender][_voted] == false, "you've already voted");
        voteStatus[msg.sender][_voted] = true;
        voteCount[_voted] ++;
    }

    function getAddresses() external view returns(address[] memory){
        return Admins;
    }

    function calVote() internal view returns (uint) {
       uint size = Admins.length;
       return (size * 70)/100;
    }

    function deleteAdmin(address _addr) external onlyAdmins(msg.sender){
        uint size = Admins.length;
        uint voteCal = calVote();
        require(voteCount[_addr] > voteCal, "Total number did not agree");
        adminStatus[_addr] = false;

        address[] memory addressMemory = new address[](size);
        addressMemory = Admins;
        for(uint i = 0; i < size; i++){
            if(_addr == addressMemory[i]){
                addressMemory[i] = addressMemory[size - 1];
                Admins = addressMemory;
                break;
            }
        }
        Admins.pop();

    }
    receive() external payable {}
}


