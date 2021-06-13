import * as dotenv from "dotenv";
dotenv.config({ path: __dirname+'/.env' });
import "@nomiclabs/hardhat-etherscan";
import { task } from "hardhat/config";
import "@nomiclabs/hardhat-waffle";
import "@nomiclabs/hardhat-ethers";
/**
 * @type import('hardhat/config').HardhatUserConfig
 */

task("accounts", "Prints the list of accounts", async (args, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

const local = {
  solidity: "0.7.0",
  networks: {
    hardhat: {
    },
  },
};

const with_kovan = {
  solidity: "0.7.0",
  networks: {
    hardhat: {
      forking: {
        url: process.env.ALCHEMY_MAINNET_RPC_URL
      }
    },
    kovan: {
      url: process.env.ALCHEMY_KOVAN_RPC_URL,
      accounts: [`0x${process.env.KOVAN_PRIVATE_KEY}`]
    },
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY
  }
};

const config = process.env.ALCHEMY_KOVAN_RPC_URL ? with_kovan : local;

export default config;