import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "hardhat-deploy"
import dotenv from "dotenv"
dotenv.config()

// @ts-ignore
const config: HardhatUserConfig = {
  solidity: "0.8.17",
  networks: {
    hardhat: {
      forking: {
        url: `${process.env.CHAINSTACK_MUMBAI_URL}`
      }
    },

    mumbai: {
      url: `${process.env.CHAINSTACK_MUMBAI_URL}`,
      chainId: 80001,
      // @ts-ignore
      name: "mumbai",
      accounts: [`${process.env.PRIVATE_KEY}`],
      allowUnlimitedContractSize: true,

    },
    goerli: {
      url: `${process.env.GOERLI_URL}`,
      accounts: [`${process.env.PRIVATE_KEY}`],
      gas: 2100000,
      gasPrice: 8000000000,

    }
  }
};

export default config;
