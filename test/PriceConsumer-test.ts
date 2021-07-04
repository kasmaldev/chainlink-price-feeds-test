import { expect } from "chai";
import { ethers } from "hardhat"

const LINK = '0x514910771AF9Ca656af840dff83E8264EcF986CA' // Mainnet LINK ERC20 address
const USD = '0x0000000000000000000000000000000000000348' // Hexadecimal of ISO 4217
const JPY = '0x0000000000000000000000000000000000000188' // Hexadecimal of ISO 4217
const ETH = '0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE' 

describe("PriceConsumer", function() {
  it("Should return latest price", async function() {
    const PriceConsumer = await ethers.getContractFactory("PriceConsumer");
    const consumer = await PriceConsumer.deploy();
    await consumer.deployed();

    const LinkUsd = await consumer.getThePrice(LINK, USD)
    expect(LinkUsd.gte(0));
    console.log(LinkUsd.toNumber()/ 10 ** 8)
    const EthUsd = await consumer.getThePrice(ETH, USD)
    console.log(EthUsd.toNumber() / 10 ** 8)
    const JpyUsd = await consumer.getThePrice(JPY, USD)
    console.log(JpyUsd.toNumber())
    // const fiatData = await consumer.getEthFiat(ETH, JPY)
    // console.log(formatEther(fiatData))
    // expect(fiatData.gte(0));
  });
});