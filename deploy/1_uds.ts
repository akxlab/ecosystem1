import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';
import {ethers, upgrades} from 'hardhat';

const {utils} = require("ethers");


const func0: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
    const {deployments, getNamedAccounts} = hre;
    const {deploy} = deployments;
    const deployers = await hre.ethers.getSigners();
    const deployer = '0xc956BbcA545e0071Edcd14AE0531F7fa94D33771';

    console.log("Deploying contracts with the account:", deployer);

    console.log("Account balance:", (await deployers[0].getBalance()).toString());

const rootNode = utils.keccak256(`${deployer}`);

  

   /*const UserDataResolver = await deploy("UserDataServiceResolver", {
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
    });*/

    const PSL = await deploy("PrivateSaleLogic", {
        from: deployer,
        args: [deployer],
        log: true,
        autoMine: true,
        waitConfirmations:2,
        //gasLimit: 20287350, gasPrice: "252873500"
    });

    const IDRegistry = await deploy("IdentityRegistry", {
        from: deployer,
        args: [],
        log: true,
        autoMine: true,
        waitConfirmations:2,
        //gasLimit: 20287350, gasPrice: "252873500"
    });


    
  /*  const labz = await deploy("LabzERC20", {
        from: deployer,
        args: [],
        log: true,
        autoMine: true,
        waitConfirmations:2,
        gasLimit: 20287350, gasPrice: "252873500"
    });*/

   /* const rlogic = await deploy("ReferralLogic", {
        from: deployer,
        args: [],
        log: true,
        autoMine: true,
        waitConfirmations:2,
        //gasLimit: 20287350, gasPrice: "252873500"
    });

    const refContract = await deploy("Referrals", {
        from: deployer,
        args: [labz.address, rlogic.address],
        log: true,
        autoMine: true,
        waitConfirmations:2,
       //gasLimit: 20287350, gasPrice: "252873500"
    });

    const sys = await ethers.getContractFactory("AKXSystem");
    const args = ["1", "AKXSystem", deployer];
    const System = await upgrades.deployProxy(sys,args,  {kind: "uups", initializer:"initialize", unsafeAllow:["constructor", "delegatecall"]});
*/


  
    

   /* const Wrapper = await ethers.getContractFactory("LABZ");
    const args = [labz.address];
    const wrapper = await upgrades.deployProxy(Wrapper, args, {kind: "uups", initializer:"initialize", unsafeAllow:["constructor", "delegatecall"]});
    await wrapper.deployed();


    instance.initialize('0x8236088bf233De07EF9CF411794dEc3f72BdB8aa', UserDataResolver.address);*/


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