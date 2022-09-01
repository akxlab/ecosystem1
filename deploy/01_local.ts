import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';
import { ethers } from 'hardhat';
const {utils} = require("ethers");


const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {

    // @ts-ignore
    const {deployments, getNamedAccounts, ethers} = hre;
    const {deploy} = deployments;
    const deployers = await ethers.getSigners();
    const deployer = deployers[0].address;
    console.log(deployer);

    const UDS = await ethers.getContractFactory("UDS");
    const uds = await UDS.deploy();
    await uds.deployTransaction.wait(2);

    const service = await ethers.getContractFactory("UserDataServiceResolver")
    const s = await service.deploy(uds.address);
    await s.deployTransaction.wait(2);

    const didRegistry = await ethers.getContractFactory("contracts/modules/DidRegistry.sol:DidRegistry");
    const did = await didRegistry.deploy();
    await did.deployTransaction.wait(2);

    const baseRegistry = await ethers.getContractFactory("BaseUserRegistry");
    const rootNode = ethers.utils.solidityKeccak256(['string'],[ethers.utils.defaultAbiCoder.encode(['string'], [deployer])]);
    const base = await baseRegistry.deploy(rootNode, uds.address);
    await base.deployTransaction.wait(2);

    console.log(` CONTRACTS ADDRESSES: \n\n uds: ${uds.address}, \n\n dataservice: ${s.address}, \n\n didregistry: ${did.address}, \n\n baseUserRegistry: ${base.address}`);

}

export default func;