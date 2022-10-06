import BN from "bignumber.js";
import { ethers } from "hardhat";
import { BigNumber, BigNumberish } from "ethers";

const be = ethers.utils.parseEther("8.42");
const b:BigNumberish = BigNumber.from(be);





console.log(b.toHexString());