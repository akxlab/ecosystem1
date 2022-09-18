import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
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
      gasPrice: ethers.utils.parseEther("0.00037").toNumber(),
      minGasPrice: ethers.utils.parseEther("0.00037").toNumber(),
      gas: 5000000000000
    }
  }
};

export default config;
