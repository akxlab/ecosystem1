import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "hardhat-ethernal"
import "hardhat-deploy"
import dotenv from "dotenv"
dotenv.config()

// @ts-ignore
const config: HardhatUserConfig = {
  solidity: "0.8.16",
  ethernal: {
    disabled: false,
    uploadAst:true,
    disableSync: false,
    disableTrace: false
  },
  networks: {
    hardhat: {
      forking: {
        url: `${process.env.CHAINSTACK_MUMBAI_URL}`
      }
    },

    mumbai: {
      url: `https://nd-676-017-409.p2pify.com/292cd9728f27e636f5ec245565ad9d04`,
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
