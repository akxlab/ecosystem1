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
        runs: 200
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
      url: `${process.env.CHAINSTACK_MUMBAI_URL}`,
      chainId: 80001,
      // @ts-ignore
      name: "mumbai",
      accounts: [`${process.env.PRIVATE_KEY_LOCAL}`],
      allowUnlimitedContractSize: true,
      gasPrice: 3528735000

    },
   polygon: {
      url: `${process.env.POLYGON_URL}`,
      chainId: 137,
      // @ts-ignore
      name: "polygon",
      accounts: [`${process.env.POLYGON_PK}`],
      from: process.env.DEPLOYER,
      allowUnlimitedContractSize: true,
      gasLimit: "auto", gasPrice: 55000000000

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
    apiKey: 
     process.env.POLYGON_KEY || "" 
   
  },
  gasReporter: {
		currency: 'USD',
		enabled: process.env.REPORT_GAS ? true : false,
		coinmarketcap: process.env.CMCPRO_API,
		maxMethodDiff: 10
	},
  tenderly: {
		project: 'akx3',
		username: process.env.TENDERLY_API as string
	}
};

export default config;
