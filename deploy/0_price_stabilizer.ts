import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';
import {ethers} from 'hardhat';

const {utils} = require("ethers");


const func0: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
    const {deployments, getNamedAccounts} = hre;
    const {deploy} = deployments;
    const deployers = await hre.ethers.getSigners();
    const deployer = deployers[0].address;

    const PS = await deploy("PriceStabilizerLabzMatics", {
        from: deployer,
        args: [],
        log: true,
        autoMine: true,
        waitConfirmations:2
    });

    console.log(PS.address);
}

export default func0;