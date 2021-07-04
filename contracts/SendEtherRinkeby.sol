// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/utils/math/SafeCast.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract SendEtherRinkeby {
    using SafeCast for int256;
    using SafeMath for uint256;

    AggregatorV3Interface internal eth_usd_price_feed;
    AggregatorV3Interface internal jpy_usd_price_feed;
    AggregatorV3Interface internal gbp_usd_price_feed;
    AggregatorV3Interface internal eur_usd_price_feed;
    AggregatorV3Interface internal aud_usd_price_feed;

    /**
     * Network: Rinkeby
     */
    constructor() {
        eth_usd_price_feed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        jpy_usd_price_feed = AggregatorV3Interface(0x3Ae2F46a2D84e3D5590ee6Ee5116B80caF77DeCA);
        gbp_usd_price_feed = AggregatorV3Interface(0x7B17A813eEC55515Fb8F49F2ef51502bC54DD40F);
        eur_usd_price_feed = AggregatorV3Interface(0x78F9e60608bF48a1155b4B2A5e31F32318a1d85F);
        aud_usd_price_feed = AggregatorV3Interface(0x21c095d2aDa464A294956eA058077F14F66535af);
    }

    function getEthUsd() public view returns (uint) {
        (
            , int price, , , 
        ) = eth_usd_price_feed.latestRoundData();

        return price.toUint256();
    }


    function getEthJpy() public view returns (uint) {
        (
            , int price, , , 
        ) = jpy_usd_price_feed.latestRoundData();

        uint EthUsd = getEthUsd();
        uint JpyUsd = price.toUint256();

        return EthUsd.mul(10 ** 8).div(JpyUsd);
    }

    function getEthEur() public view returns (uint) {
        (
            , int price, , , 
        ) = eur_usd_price_feed.latestRoundData();

        uint EthUsd = getEthUsd();
        uint EurUsd = price.toUint256();

        return EthUsd.mul(10 ** 8).div(EurUsd);
    }

    function getEthAud() public view returns (uint) {
        (
            , int price, , , 
        ) = aud_usd_price_feed.latestRoundData();

        uint EthUsd = getEthUsd();
        uint AudUsd = price.toUint256();

        return EthUsd.mul(10 ** 8).div(AudUsd);
    }

    function getEthGbp() public view returns (uint) {
        (
            , int price, , , 
        ) = gbp_usd_price_feed.latestRoundData();

        uint EthUsd = getEthUsd();
        uint GbpUsd = price.toUint256();

        return EthUsd.mul(10 ** 8).div(GbpUsd);
    }

    function convertEthUsd(uint _amountInUsd) public view returns (uint) {

        uint EthUsd = getEthUsd();

        return _amountInUsd.mul(10 ** 16).div(EthUsd);

    }
    
    function convertEthJpy(uint _amountInJpy) public view returns (uint) {

        uint EthJpy = uint(getEthJpy());

        return _amountInJpy.mul(10 ** 16).div(EthJpy);

    }

     function convertEthAud(uint _amountInAud) public view returns (uint) {

        uint EthAud = uint(getEthAud());

        return _amountInAud.mul(10 ** 16).div(EthAud);

    }   

     function convertEthEur(uint _amountInEur) public view returns (uint) {

        uint EthEur = uint(getEthEur());

        return _amountInEur.mul(10 ** 16).div(EthEur);

    }   

     function convertEthGbp(uint _amountInGbp) public view returns (uint) {

        uint EthGbp = uint(getEthGbp());

        return _amountInGbp.mul(10 ** 16).div(EthGbp);

    }   

}