import { ethers } from "hardhat";

const ETHERSCAN_TX_URL = "https://kovan.etherscan.io/tx/"

async function main() {
  const Contract = await ethers.getContractFactory("SendEther");

  const contract = await Contract.deploy();

  console.log("Token deployed to:", contract.address);
  console.log(
    `You did it! View your tx here: ${ETHERSCAN_TX_URL}${contract.deployTransaction.hash}`
  )
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });