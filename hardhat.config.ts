import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
<<<<<<< Updated upstream
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
=======
import "hardhat-deploy";
import dotenv from "dotenv";
dotenv.config();

const config: HardhatUserConfig = {
  solidity: "0.8.16",
  networks: {
    akx: {
      url: "https://nd-676-017-409.p2pify.com/292cd9728f27e636f5ec245565ad9d04",
      chainId: 80001,
      from: "0xc956BbcA545e0071Edcd14AE0531F7fa94D33771",
      accounts: [process.env.PRIVATE_KEY || ""]
    }
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY
  },
>>>>>>> Stashed changes
};

export default config;
