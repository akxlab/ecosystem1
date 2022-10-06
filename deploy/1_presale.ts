import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';
import {ethers, upgrades} from 'hardhat';

const {utils} = require("ethers");


const presale: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {

    const {deployments, getNamedAccounts} = hre;
	const {deploy} = deployments;
    
   /* const Presale = await deploy("AKXTokenLogic", {
        from: deployer,
        args: [symbol, feeLogic.address, token.address, oracle.address, basePrice],
        log: true,
        autoMine: true,
        waitConfirmations:2,
    });  */

}

presale.tags = ['presale'];

export default presale;