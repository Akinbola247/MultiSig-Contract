// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

interface Imultisig {
    function addAdmin(address _newAdmin) external;
    function vote(address _voted) external;
    function getAddresses() external view returns(address[] memory);
    function deleteAdmin(address _addr) external;
    function calVote() external view returns (uint);
}