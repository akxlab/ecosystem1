import { ethers } from "hardhat";
import akx3 from "../deployments/mumbai/AKX3.json";
import akxlogic from "../deployments/mumbai/AKXTokenLogic.json";
import oracle from "../deployments/mumbai/PriceOracle.json";

const akx3Addr = akx3.address;
const akxLogic = akxlogic.address;
const priceOracle = oracle.address;




async function main() {

    const signers = await ethers.getSigners();
    const signer = signers[0];
    const deployer = signer.address;
    const TREASURY = deployer;
    const FEEWALLET = deployer;

    const mainContract = await ethers.getContractAt("AKXTokenLogic", akxLogic);
    const token = await ethers.getContractAt("AKX3", akx3Addr);
    const pOracle = await ethers.getContractAt("PriceOracle", priceOracle);
   // await (await pOracle.transferOwnership(akxLogic)).wait();

  
    await (await mainContract.setEthPrice(ethers.utils.parseEther("0.000073"))).wait();
    
    
    await (await mainContract.setFeeWallet(FEEWALLET)).wait();
    await (await mainContract.setTreasury(TREASURY)).wait();
   




};


// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });
  