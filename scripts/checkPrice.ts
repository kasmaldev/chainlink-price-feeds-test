import { run, ethers } from "hardhat";
// import PriceConverterABI from "../artifacts/contracts/PriceConverter.sol/PriceConverter.json";

async function main() {

    const PriceConverterABI = [
    {
      "inputs": [],
      "stateMutability": "nonpayable",
      "type": "constructor"
    },
    {
      "inputs": [
        {
          "internalType": "int256",
          "name": "input",
          "type": "int256"
        }
      ],
      "name": "convertPrice",
      "outputs": [
        {
          "internalType": "int256",
          "name": "",
          "type": "int256"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    },
    {
      "inputs": [],
      "name": "getThePrice",
      "outputs": [
        {
          "internalType": "int256",
          "name": "",
          "type": "int256"
        }
      ],
      "stateMutability": "view",
      "type": "function"
    }
  ]
    const provider = ethers.provider;
    const contractAddress = "0xe4D23c26945Bb14DaD7Fdf1eccF1279Ac92612D4"
    const converterContract = new ethers.Contract(contractAddress, PriceConverterABI, provider)

	console.log(await converterContract.getThePrice());
	console.log(await converterContract.convertPrice(50000));

}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });