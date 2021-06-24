// SPDX-License-Identifier: MIT
pragma solidity 0.7.0;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

contract SendEtherKovan {
    AggregatorV3Interface internal eth_usd_price_feed;
    AggregatorV3Interface internal jpy_usd_price_feed;
    AggregatorV3Interface internal gbp_usd_price_feed;
    AggregatorV3Interface internal eur_usd_price_feed;
    AggregatorV3Interface internal aud_usd_price_feed;

    constructor() {
        eth_usd_price_feed = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
        jpy_usd_price_feed = AggregatorV3Interface(0xD627B1eF3AC23F1d3e576FA6206126F3c1Bd0942);
        gbp_usd_price_feed = AggregatorV3Interface(0x28b0061f44E6A9780224AA61BEc8C3Fcb0d37de9);
        eur_usd_price_feed = AggregatorV3Interface(0x0c15Ab9A0DB086e062194c273CC79f41597Bbf13);
        aud_usd_price_feed = AggregatorV3Interface(0x5813A90f826e16dB392abd2aF7966313fc1fd5B8);
    }

    /**
    * @notice contract can receive Ether.
    */

    receive() external payable {}
	
    function getEthUsd() public view returns (int) {
        (
            uint80 roundID, 
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = eth_usd_price_feed.latestRoundData();

        return price;
    }


    function getJpyUsd() public view returns (int) {
        (
            uint80 roundID, 
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = jpy_usd_price_feed.latestRoundData();

        return price;
    }

    function getEthEur() public view returns (uint) {
        (
            uint80 roundID, 
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = eur_usd_price_feed.latestRoundData();

        uint EthUsd = uint(getEthUsd());
        uint EurUsd = uint(price);

        return EthUsd * 10 ** 8 / EurUsd;
    }

    function getEthAud() public view returns (uint) {
        (
            uint80 roundID, 
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = aud_usd_price_feed.latestRoundData();

        uint EthUsd = uint(getEthUsd());
        uint AudUsd = uint(price);

        return EthUsd * 10 ** 8 / AudUsd;
    }

    function getEthGbp() public view returns (uint) {
        (
            uint80 roundID, 
            int price,
            uint startedAt,
            uint timeStamp,
            uint80 answeredInRound
        ) = gbp_usd_price_feed.latestRoundData();

        uint EthUsd = uint(getEthUsd());
        uint GbpUsd = uint(price);

        return EthUsd * 10 ** 8 / GbpUsd;
    }

    function getEthJpy() public view returns (uint) {

        uint EthUsd = uint(getEthUsd());
        uint JpyUsd = uint(getJpyUsd());

        return EthUsd * 10 ** 8 / JpyUsd;

    }

    function convertEthUsd(uint _amountInUsd) public view returns (uint) {

        uint EthUsd = uint(getEthUsd());

        return _amountInUsd * 10 ** 16 / EthUsd;

    }
    
    function convertEthJpy(uint _amountInJpy) public view returns (uint) {

        uint EthJpy = uint(getEthJpy());

        return _amountInJpy * 10 ** 16 / EthJpy;

    }

     function convertEthAud(uint _amountInAud) public view returns (uint) {

        uint EthAud = uint(getEthAud());

        return _amountInAud * 10 ** 16 / EthAud;

    }   

     function convertEthEur(uint _amountInEur) public view returns (uint) {

        uint EthEur = uint(getEthAud());

        return _amountInEur * 10 ** 16 / EthEur;

    }   

     function convertEthGbp(uint _amountInGbp) public view returns (uint) {

        uint EthGbp = uint(getEthGbp());

        return _amountInGbp * 10 ** 16 / EthGbp;

    }   

    function sendViaCall(address payable _to) public payable {
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        (bool sent, ) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }

}