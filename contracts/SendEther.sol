// SPDX-License-Identifier: MIT
pragma solidity 0.7.0;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";

contract SendEtherKovan {
    AggregatorV3Interface internal eth_usd_price_feed;
    AggregatorV3Interface internal jpy_usd_price_feed;
    AggregatorV3Interface internal gbp_usd_price_feed;
    AggregatorV3Interface internal eur_usd_price_feed;
    AggregatorV3Interface internal aud_usd_price_feed;
    AggregatorV3Interface internal cny_usd_price_feed;
    AggregatorV3Interface internal cad_usd_price_feed;

    constructor() {
        eth_usd_price_feed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
        jpy_usd_price_feed = AggregatorV3Interface(0xBcE206caE7f0ec07b545EddE332A47C2F75bbeb3);
        gbp_usd_price_feed = AggregatorV3Interface(0x5c0Ab2d9b5a7ed9f470386e82BB36A3613cDd4b5);
        eur_usd_price_feed = AggregatorV3Interface(0xb49f677943BC038e9857d61E7d053CaA2C1734C1);
        aud_usd_price_feed = AggregatorV3Interface(0x77F9710E7d0A19669A13c055F62cd80d313dF022);
        cny_usd_price_feed = AggregatorV3Interface(0xeF8A4aF35cd47424672E3C590aBD37FBB7A7759a);
        cad_usd_price_feed = AggregatorV3Interface(0xa34317DB73e77d453b1B8d04550c44D10e981C8e);
    }

    /**
    * @notice contract can receive Ether.
    */

    receive() external payable {}
	
    function getEthUsd() public view returns (uint) {
        (
            , int price, , , 
        ) = eth_usd_price_feed.latestRoundData();

        return uint(price);
    }


    function getEthJpy() public view returns (uint) {
        (
            , int price, , , 
        ) = jpy_usd_price_feed.latestRoundData();

        uint EthUsd = getEthUsd();
        uint JpyUsd = uint(price);

        return EthUsd * 10 ** 8 / JpyUsd;
    }

    function getEthEur() public view returns (uint) {
        (
            , int price, , , 
        ) = eur_usd_price_feed.latestRoundData();

        uint EthUsd = getEthUsd();
        uint EurUsd = uint(price);

        return EthUsd * 10 ** 8 / EurUsd;
    }

    function getEthAud() public view returns (uint) {
        (
            , int price, , , 
        ) = aud_usd_price_feed.latestRoundData();

        uint EthUsd = getEthUsd();
        uint AudUsd = uint(price);

        return EthUsd * 10 ** 8 / AudUsd;
    }

    function getEthGbp() public view returns (uint) {
        (
            , int price, , , 
        ) = gbp_usd_price_feed.latestRoundData();

        uint EthUsd = getEthUsd();
        uint GbpUsd = uint(price);

        return EthUsd * 10 ** 8 / GbpUsd;
    }

    function getEthCny() public view returns (uint) {
        (
            , int price, , , 
        ) = cny_usd_price_feed.latestRoundData();

        uint EthUsd = getEthUsd();
        uint CnyUsd = uint(price);

        return EthUsd * 10 ** 8 / CnyUsd;
    }

    function getEthCad() public view returns (uint) {
        (
            , int price, , , 
        ) = cad_usd_price_feed.latestRoundData();

        uint EthUsd = getEthUsd();
        uint CadUsd = uint(price);

        return EthUsd * 10 ** 8 / CadUsd;
    }

    function convertEthUsd(uint _amountInUsd) public view returns (uint) {

        uint EthUsd = getEthUsd();

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

        uint EthEur = uint(getEthEur());

        return _amountInEur * 10 ** 16 / EthEur;

    }   

    function convertEthGbp(uint _amountInGbp) public view returns (uint) {

        uint EthGbp = uint(getEthGbp());

        return _amountInGbp * 10 ** 16 / EthGbp;

    }   

    function convertEthCny(uint _amountInCny) public view returns (uint) {

        uint EthCny = uint(getEthCny());

        return _amountInCny * 10 ** 16 / EthCny;

    }   

    function convertEthCad(uint _amountInCad) public view returns (uint) {

        uint EthCad = uint(getEthCad());

        return _amountInCad * 10 ** 16 / EthCad;

    }   

}