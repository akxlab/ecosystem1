import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "hardhat-ethernal"
import "hardhat-deploy"
import dotenv from "dotenv"
dotenv.config()

const config: HardhatUserConfig = {
  solidity: "0.8.16",
  ethernal: {
    disabled: false,
    uploadAst:true,
    disableSync: false,
    disableTrace: false
  }
};

export default config;
