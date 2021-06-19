import { ethers } from "hardhat";
import { formatEther, parseEther } from '@ethersproject/units';
import { mySecondAddress } from "../constants";

const ETHERSCAN_TX_URL = "https://kovan.etherscan.io/tx/"

async function main() {

    const contractAddress = "0x5F400177F2E6D5207B76BD35efc68f9D0a6DbD00"
    const PriceConverterContract = await ethers.getContractFactory("SendEther");
    const contract = PriceConverterContract.attach(contractAddress);
    const ethusd = await contract.getEthUsd();
    const jpyusd = await contract.getJpyUsd();
    const getEthJpy = await contract.getEthJpy(3000);

    console.log("ETH/USD", ethusd.toNumber() / 10 ** 8)
    console.log("JPY/USD", jpyusd.toNumber() / 10 ** 8)
    console.log(getEthJpy.toNumber() / 10 ** 8)

    const transferEther = await contract.transferEther(
        mySecondAddress, 450
	)
    console.log(
        `You did it! View your tx here: ${ETHERSCAN_TX_URL}${transferEther.hash}`
    )

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