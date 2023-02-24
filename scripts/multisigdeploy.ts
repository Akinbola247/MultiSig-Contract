import { ethers } from "hardhat";
async function main() {
    const [owner, owner2, owner3] = await ethers.getSigners();
    // const admins = [owner.address, owner2.address, owner3.address]
    // const MultiSigFactory = await ethers.getContractFactory("multiSigfactory");
    // const multiSigFactory = await MultiSigFactory.deploy();
    // await multiSigFactory.deployed();
    // console.log(`Deployment succesful your multiSig address is ${multiSigFactory.address}`);

    // const createContract = await multiSigFactory.DeployContract(admins);
    // const event = await createContract.wait();
    // const contractAddress = event.events[0].args[0];
    // console.log(contractAddress);

    const childContract = await ethers.getContractAt("Imultisig", "0x066C1BeE87CBaCC5E2aD110fe8Cd6d79743243d7");
    const getAddress = await childContract.getAddresses();
    console.log(getAddress);
    
    
    const vote = await childContract.connect(owner).vote("0x7bf78028E53e76a322b4B07bdA6362720D4E64F3");
    const vote1 = await childContract.connect(owner2).vote("0x7bf78028E53e76a322b4B07bdA6362720D4E64F3");
    const vote2 = await childContract.connect(owner3).vote("0x7bf78028E53e76a322b4B07bdA6362720D4E64F3");

    const AddAdmin = await childContract.addAdmin("0x7bf78028E53e76a322b4B07bdA6362720D4E64F3");
    const getAddress2 = await childContract.getAddresses();
    console.log(getAddress2);


}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });