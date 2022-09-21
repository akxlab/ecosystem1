import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@openzeppelin/hardhat-upgrades";
import "hardhat-deploy"
import dotenv from "dotenv"
import { ethers } from "ethers";
dotenv.config()

// @ts-ignore
const config: HardhatUserConfig = {
  solidity: {
    version:"0.8.17",
    settings: {
      optimizer: {
        enabled: true,
        runs: 800
      }
    }
  },
  networks: {
    hardhat: {
      forking: {
        url: `${process.env.CHAINSTACK_MUMBAI_URL}`
      }
    },

    mumbai: {
      url: `${process.env.MUMBAI_URL}`,
      chainId: 80001,
      // @ts-ignore
      name: "mumbai",
      accounts: [`${process.env.PRIVATE_KEY_LOCAL}`],
      allowUnlimitedContractSize: true,

    },
    goerli: {
      url: `${process.env.GOERLI_URL}`,
      chainId: 5,
      // @ts-ignore
      name: "goerli",
      // @ts-ignore
      accounts:  [`${process.env.PRIVATE_KEY}`],
      allowUnlimitedContractSize: true,
      gasLimit: 20287350, gasPrice: 252873500
    }
  },
  etherscan: {
    apiKey: {
      "goerli": process.env.ETHERSCAN_API_KEY || "",
    }
  }
};

export default config;
