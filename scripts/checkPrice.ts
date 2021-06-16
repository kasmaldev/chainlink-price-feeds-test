import { ethers } from "hardhat";

async function main() {


    const contractAddress = "0x179f77638D890c44e5a21f29767aE5648CebA00E"
    const PriceConverterContract = await ethers.getContractFactory("PriceConverter");
    const contract = PriceConverterContract.attach(contractAddress);
    const ethusd = await contract.getEthUsd();
    const jpyusd = await contract.getJpyUsd();

    // useful link: https://ethereum.stackexchange.com/questions/95023/hardhat-how-to-interact-with-a-deployed-contract

    console.log("ETH/USD", ethusd.toNumber()/10**8)
    console.log("JPY/USD", jpyusd.toNumber()/10**8)

}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });