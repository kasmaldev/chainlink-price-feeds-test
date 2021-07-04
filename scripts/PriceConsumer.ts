import { ethers } from "hardhat";

const LINK = '0x514910771AF9Ca656af840dff83E8264EcF986CA' // Mainnet LINK ERC20 address
const USD = '0x0000000000000000000000000000000000000348' // Hexadecimal of ISO 4217
const JPY = '0x0000000000000000000000000000000000000188' // Hexadecimal of ISO 4217
const ETH = '0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE' 

async function main() {

    const Contract = await ethers.getContractFactory("PriceConsumer");
	const contract = await Contract.deploy();

    const LinkUsd = await contract.getThePrice(LINK, USD)
    console.log(LinkUsd.toNumber()/ 10 ** 8)
    const EthUsd = await contract.getThePrice(ETH, USD)
    console.log(EthUsd.toNumber() / 10 ** 8)
    const JpyUsd = await contract.getThePrice(JPY, USD)
    console.log(JpyUsd.toNumber())

}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });