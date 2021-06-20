import { ethers } from "hardhat";
import { formatEther, parseEther } from '@ethersproject/units';
import { mySecondAddress } from "../constants";

const ETHERSCAN_TX_URL = "https://kovan.etherscan.io/tx/"

async function main() {

    const contractAddress = "0x5886ee044B31f4cB8B99DeA2b6C5Ff148BD84F93"
    const PriceConverterContract = await ethers.getContractFactory("SendEther");
    const contract = PriceConverterContract.attach(contractAddress);
    const ethusd = await contract.getEthUsd();
    const jpyusd = await contract.getJpyUsd();
    const getEthJpy = await contract.getEthJpy();

    console.log("ETH/USD", ethusd.toNumber() / 10 ** 8)
    console.log("JPY/USD", jpyusd.toNumber() / 10 ** 8)
    console.log("ETH/JPY", getEthJpy.toNumber() / 10 ** 8)


    const amountInJpy = 5000;
    const transferEther = await contract.convertEthJpy(
        amountInJpy
    )
    console.log(`${amountInJpy} JPY is worth ${transferEther.toNumber() / 10 ** 8} ETH`)

    // const getJpyEth = await contract.getJpyEth(3000);
    // console.log(getJpyEth.toNumber() / 10 ** 8)

    // const transferJpyEth = await contract.transferEther(
    //     mySecondAddress, 45000
    // )

    // console.log(
    //     `You did it! View your tx here: ${ETHERSCAN_TX_URL}${transferJpyEth.hash}`
    // )

}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });