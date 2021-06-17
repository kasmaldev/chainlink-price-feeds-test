import { ethers } from "hardhat";
import { formatEther } from '@ethersproject/units';

async function main() {


    const contractAddress = "0x362b6503a99c63cDFc345751F1F53CBD5Ce825Dc"
    const PriceConverterContract = await ethers.getContractFactory("PriceConverter");
    const contract = PriceConverterContract.attach(contractAddress);
    const ethusd = await contract.getEthUsd();
    const jpyusd = await contract.getJpyUsd();
    const balance = await contract.getBalance();

    console.log("current balance", formatEther(balance))

    // useful link: https://ethereum.stackexchange.com/questions/95023/hardhat-how-to-interact-with-a-deployed-contract

    console.log("ETH/USD", ethusd.toNumber()/10**8)
    console.log("JPY/USD", jpyusd.toNumber()/10**8)

    const sendEth = await contract.firstSendEther("0xB0fD1307c2e0d088424fa4939F53303974421924")
    const transferEth = await contract.transferEther(
        "0xB0fD1307c2e0d088424fa4939F53303974421924", 0.05)
    console.log(sendEth)
    console.log(transferEth)

}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });