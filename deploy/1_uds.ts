import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';
import {ethers} from 'hardhat';

const {utils} = require("ethers");


const func0: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
    const {deployments, getNamedAccounts} = hre;
    const {deploy} = deployments;
    const deployers = await hre.ethers.getSigners();
    const deployer = deployers[0].address;

    console.log("Deploying contracts with the account:", deployer);

    console.log("Account balance:", (await deployers[0].getBalance()).toString());

const rootNode = utils.keccak256(`${deployer}`);

    const UDS = await deploy("UDS", {
        from: deployer,
        args: [],
        log: true,
        autoMine: true,
        waitConfirmations:2,
        gasLimit: 20287350, gasPrice: "252873500"
    });

    const UserDataResolver = await deploy("UserDataServiceResolver", {
        from: deployer,
        args: [rootNode, UDS.address],
        log: true,
        autoMine: true,
        waitConfirmations:2,
        gasLimit: 20287350, gasPrice: "252873500"
    });

    const did = await deploy("DidRegistry", {
        from: deployer,
        args: [],
        log: true,
        autoMine: true,
        waitConfirmations:2,
        gasLimit: 20287350, gasPrice: "252873500"
    });



    
    const labz = await deploy("LabzERC2055", {
        from: deployer,
        args: ['0x8236088bf233De07EF9CF411794dEc3f72BdB8aa', UserDataResolver.address],
        log: true,
        autoMine: true,
        waitConfirmations:2,
        gasLimit: 20287350, gasPrice: "252873500"
    });

    //    function initialize(address ethrdid, address labztoken, address uds, address dex, address gov, address akxtoken) public onlyNotInitialized {

    /*const akx = await deploy("AKXEcosystem", {
        from: deployer,
        args: [[did.address,labz.address, UDS.address, '0x0000000000000000000000000000000000001010','0x0000000000000000000000000000000000001010','0x0000000000000000000000000000000000001010']],
        log: true,
        autoMine: true,
        waitConfirmations:2,
        gasLimit: 8225383 
    });*/

   /* const proxyFactory = await deploy("AKXProxyFactory", {
        from: deployer,
        args: [],
        log: true,
        autoMine: true,
        waitConfirmations:2,
        gasLimit: 8225383
    });*/

}

export default func0;