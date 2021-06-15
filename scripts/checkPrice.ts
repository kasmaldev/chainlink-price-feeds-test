import { ethers } from "hardhat";
import { formatEther } from "@ethersproject/units";

async function main() {


    const contractAddress = "0xe4D23c26945Bb14DaD7Fdf1eccF1279Ac92612D4"
    const PriceConverterContract = await ethers.getContractFactory("PriceConverter");
    const contract = await PriceConverterContract.attach(contractAddress);
    const latestPrice = await contract.getThePrice();
    const convertPrice = await contract.convertPrice(50000);

    // useful link: https://ethereum.stackexchange.com/questions/95023/hardhat-how-to-interact-with-a-deployed-contract

    console.log(latestPrice.toNumber())
    console.log(
        formatEther(latestPrice), formatEther(convertPrice)
    )

}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });