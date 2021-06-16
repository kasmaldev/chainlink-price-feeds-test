// SPDX-License-Identifier: MIT
pragma solidity 0.7.0;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

contract PriceConverter {
    AggregatorV3Interface internal eth_usd_price_feed;
    AggregatorV3Interface internal jpy_usd_price_feed;

    /**
     * Network: Kovan
     * Aggregator: ETH/USD
     * Address: 0x9326BFA02ADD2366b30bacB125260Af641031331

     * Aggregator: JPY/USD
     * Address: 0xBcE206caE7f0ec07b545EddE332A47C2F75bbeb3
     */
    constructor() {
        eth_usd_price_feed = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
        jpy_usd_price_feed = AggregatorV3Interface(0xBcE206caE7f0ec07b545EddE332A47C2F75bbeb3);
    }

    /**
     * Returns the latest price
     */
    function getThePrice() public view returns (int) {
        (
            uint80 roundID, 
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = eth_usd_price_feed.latestRoundData();

        return price;
    }

    function convertPrice(int input) public view returns (int) {
        (
            uint80 roundID, 
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = eth_usd_price_feed.latestRoundData();

        (
            uint80 jroundID, 
            int jprice,
            uint jpystartedAt,
            uint jpytimeStamp,
            uint80 jpyansweredInRound
        ) = jpy_usd_price_feed.latestRoundData();

        require(input > 0, "The input should be a positive number.");

        int currentRate = 110;
        // int currentRate = 109.79;

        return input / price / currentRate;

    }

}