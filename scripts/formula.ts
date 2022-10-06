import { ethers } from "hardhat";
import akx3 from "../deployments/localhost/AKX3.json";
//import akxlogic from "../deployments/localhost/AKXTokenLogic.json";
import oracle from "../deployments/localhost/PriceOracle.json";
import akxMath from "../deployments/localhost/AKXMath.json";

const akx3Addr = akx3.address;

const priceOracle = oracle.address;




async function main() {

    const signers = await ethers.getSigners();
    const signer = signers[0];
    const deployer = signer.address;
    const TREASURY = deployer;
    const FEEWALLET = deployer;

  //  const mainContract = await ethers.getContractAt("AKXTokenLogic", akxLogic);
    const token = await ethers.getContractAt("AKX3", akx3Addr);
    const pOracle = await ethers.getContractAt("PriceOracle", priceOracle);
    const f = await ethers.getContractAt("AKXMath", akxMath.address);

   // await (await pOracle.transferOwnership(akxLogic)).wait();


   
   await(await f.updateCiculatingSupply(ethers.utils.parseEther("150"))).wait();

   const c = await f.getC();

   console.log(ethers.utils.formatEther(c));

   const cv = await f.ucc();
   await cv.wait();

    let cv1 = ethers.BigNumber.from(cv.data).toString();

   
   console.log(cv1);
   
   




};


// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });
  