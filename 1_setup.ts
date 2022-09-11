import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';
import {ethers} from 'hardhat';

const {utils} = require("ethers");


const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
    // code here
    const {deployments, getNamedAccounts} = hre;
    const {deploy} = deployments;
    const deployers = await hre.ethers.getSigners();
    const deployer = deployers[0].address;
   /* const UserRegistry = await ethers.getContractFactory("UserRegistry");
    const U = await upgrades.deployProxy(UserRegistry, [deployer], {kind: "uups", initializer: "initialize"});
    await U.deployTransaction.wait(0);
    console.log(U.address);*/

    const UDS = await deploy("UDS", {
        from: deployer,
        args: [],
        log: true,
        autoMine: true,
        waitConfirmations:2
    });

    const rootNode = ethers.utils.solidityKeccak256(['string'],[ethers.utils.defaultAbiCoder.encode(['string'], [deployer])]);
    const services = await deploy("UserDataServiceResolver", {
        from: deployer,
        args: [rootNode,UDS.address],
        log: true,
        autoMine: true,
        waitConfirmations:2
    });
    const didRegistry = await deploy("DidRegistry",{contract:"contracts/modules/DidRegistry.sol:DidRegistry",
        from: deployer,
            args: [],
            log: true,
            autoMine: true,
            waitConfirmations:2
    });

    const LABZ = await deploy("LabzERC2055" ,{
        from: deployer,
        args: [],
        log: true,
        autoMine: true,
        waitConfirmations:2
    });


    //function initialize(address ethrdid, address labztoken, address uds, address dex, address gov, address akxtoken)
    const akxArgs = [didRegistry.address, LABZ.address, services.address, '0x0000000000000000000000000000000000000000', '0x0000000000000000000000000000000000000000', '0x0000000000000000000000000000000000000000'];

    const akx =  await deploy("AKX" ,{
        from: deployer,
        args: akxArgs,
        log: true,
        autoMine: true,
        waitConfirmations:2
    });

    console.log("AKX ECOSYSTEM MAIN ADDRESS", akx.address);


}

export default func;