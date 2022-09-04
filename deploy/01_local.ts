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

    //hre.ethernal.push({name: "UserDataServiceResolver", address: services.address});



    const didRegistry = await deploy("DidRegistry",{contract:"contracts/modules/DidRegistry.sol:DidRegistry",
        from: deployer,
            args: [],
            log: true,
            autoMine: true,
            waitConfirmations:2
    });

    //hre.ethernal.push({name: "DidRegistry", address: didRegistry.address});


    const ERC2055 = await deploy("ERC2055",{
        from: deployer,
        args: ["ERC2055 DEFAULT SINGLE (TEST)", "ERC2055"],
        log: true,
        autoMine: true,
        waitConfirmations:2
    });

    const ERC2055Impl = await deploy("ERC2055Implementation",{
        from: deployer,
        args: ["ERC2055 DEFAULT MULTI (TEST)", "ERC2055MULTI"],
        log: true,
        autoMine: true,
        waitConfirmations:2
    });



   /* const baseRegistry = await deploy("BaseUserRegistry", {
        from: deployer,
        args: [rootNode, UDS.address],
        log: true,
        autoMine: true,
        waitConfirmations:2
    });*/
    console.log(` RootNode: ${rootNode}`);


    console.log(` CONTRACTS ADDRESSES: \n\n uds: ${UDS.address}, \n\n dataservice: ${services.address}, \n\n didregistry: ${didRegistry.address}`);

}

export default func;