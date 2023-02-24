// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;
import {multiSig} from "./multisig.sol";

contract multiSigfactory {
    multiSig[] deployedContracts;
    event check(multiSig _contractAddress);
        function DeployContract(address[] memory _admins) public returns(multiSig){
            multiSig newContract = new multiSig(_admins);    
                      
            deployedContracts.push(newContract);
            emit check(newContract);
            return newContract;
        }

}