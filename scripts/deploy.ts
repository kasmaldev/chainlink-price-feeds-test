import { ethers } from "hardhat";

const ETHERSCAN_TX_URL = "https://kovan.etherscan.io/tx/"
const sample_token_uri = "https://ipfs.io/ipfs/Qmd9MCGtdVz2miNumBHDbvj8bigSgTwnr4SbyH6DNnpWdt?filename=0-PUG.json"

async function main() {
  const Greeter = await ethers.getContractFactory("Greeter");
  // const Token = await ethers.getContractFactory("TokenERC20");
  // const collectible = await ethers.getContractFactory("PriceConverter");
  // const greeter = await Greeter.deploy("Hello, Hardhat!");
  // const token = await Token.deploy(1000);
  const Collectible = await Greeter.deploy();

  // const newItemID = await Collectible.createCollectible(sample_token_uri)

  console.log("Token deployed to:", Collectible.address);
  console.log(
    `You did it! View your tx here: ${ETHERSCAN_TX_URL}${Collectible.deployTransaction.hash}`
  )
  // console.log({
  //   newItemID
  // })
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });