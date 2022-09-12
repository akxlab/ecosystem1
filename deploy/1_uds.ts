import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';
import {ethers} from 'hardhat';

const {utils} = require("ethers");


const func0: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
    const {deployments, getNamedAccounts} = hre;
    const {deploy} = deployments;
    const deployers = await hre.ethers.getSigners();
    const deployer = deployers[0].address;

const rootNode = utils.keccak256(`${deployer}`);

    const UDS = await deploy("UDS", {
        from: deployer,
        args: [],
        log: true,
        autoMine: true,
        waitConfirmations:2,
        gasLimit: 8225383
    });

    const UserDataResolver = await deploy("UserDataServiceResolver", {
        from: deployer,
        args: [rootNode, UDS.address],
        log: true,
        autoMine: true,
        waitConfirmations:2,
        gasLimit: 8225383
    });

    const did = await deploy("DidRegistry", {
        from: deployer,
        args: [],
        log: true,
        autoMine: true,
        waitConfirmations:2,
        gasLimit: 8225383
    });



    const akxWalletMaster = await deploy("AKXWallet", {
        from: deployer,
        args: [],
        log: true,
        autoMine: true,
        waitConfirmations:2,
        gasLimit: 8225383
    });

    const akxWalletFactory = await deploy("AKXWalletFactory", {
        from: deployer,
        args: [akxWalletMaster.address],
        log: true,
        autoMine: true,
        waitConfirmations:2,
        gasLimit: 8225383
    });

    const labz = await deploy("LabzERC2055", {
        from: deployer,
        args: [deployer, akxWalletFactory.address],
        log: true,
        autoMine: true,
        waitConfirmations:2,
        gasLimit: 8225383
    });

    //    function initialize(address ethrdid, address labztoken, address uds, address dex, address gov, address akxtoken) public onlyNotInitialized {

    const akx = await deploy("AKXEcosystem", {
        from: deployer,
        args: [[did.address,labz.address, UDS.address, '0x0000000000000000000000000000000000001010','0x0000000000000000000000000000000000001010','0x0000000000000000000000000000000000001010']],
        log: true,
        autoMine: true,
        waitConfirmations:2,
        gasLimit: 8225383 
    });

    const proxyFactory = await deploy("AKXProxyFactory", {
        from: deployer,
        args: [],
        log: true,
        autoMine: true,
        waitConfirmations:2,
        gasLimit: 8225383
    });

}

export default func0;