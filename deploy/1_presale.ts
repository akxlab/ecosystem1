import {HardhatRuntimeEnvironment} from 'hardhat/types';
import {DeployFunction} from 'hardhat-deploy/types';
import {ethers, upgrades} from 'hardhat';

const {utils} = require("ethers");


const presale: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
}

presale.tags = ['presale'];

export default presale;