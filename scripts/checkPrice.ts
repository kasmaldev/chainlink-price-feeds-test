import { ethers } from "hardhat";
import { formatEther, parseEther } from '@ethersproject/units';
import { mySecondAddress } from "../constants";

const ETHERSCAN_TX_URL = "https://kovan.etherscan.io/tx/"

async function main() {

    const contractAddress = "0x24c1103003A05BDDA51782728A023144E3e795E5"
    const PriceConverterContract = await ethers.getContractFactory("PriceConverter");
    const contract = PriceConverterContract.attach(contractAddress);
    const ethusd = await contract.getEthUsd();
    const jpyusd = await contract.getJpyUsd();
    const balance = await contract.getBalance();

    console.log("current balance", formatEther(balance))

    // useful link: https://ethereum.stackexchange.com/questions/95023/hardhat-how-to-interact-with-a-deployed-contract

    console.log("ETH/USD", ethusd.toNumber() / 10 ** 8)
    console.log("JPY/USD", jpyusd.toNumber() / 10 ** 8)

    // const transferEth = await contract.transferEther(
    //     mySecondAddress, parseEther("0.1"))

    // console.log(
    //     `You did it! View your tx here: ${ETHERSCAN_TX_URL}${transferEth.hash}`
    // )

    const getJpyEth = await contract.getJpyEth(3000);
    console.log(getJpyEth.toNumber() / 10 ** 8)

    const transferJpyEth = await contract.transferJpyEth(
        mySecondAddress, 45000
    )
    
    console.log(
        `You did it! View your tx here: ${ETHERSCAN_TX_URL}${transferJpyEth.hash}`
    )

}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });