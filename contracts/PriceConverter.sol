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
     * Address: 0xD627B1eF3AC23F1d3e576FA6206126F3c1Bd0942
     

    reference
    https://docs.chain.link/docs/ethereum-addresses/

     */
    constructor() {
        eth_usd_price_feed = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
        jpy_usd_price_feed = AggregatorV3Interface(0xD627B1eF3AC23F1d3e576FA6206126F3c1Bd0942);
    }

    /**
    * @notice contract can receive Ether.
    */
    receive() external payable {}

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    /**
     * Returns the latest price
     */
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

    function getEthJpy(uint _amountInJpy) public view returns (uint) {

        uint newInput = _amountInJpy * 10 ** 8;

        uint EthUsd = uint(getEthUsd());
        uint JpyUsd = uint(getJpyUsd());

        return newInput * JpyUsd / EthUsd;

    }


    /**
    * @dev transferring _amount Ether to 
    * the _recipient address from the contract.
    * 
    * requires: enough balance
    * 
    * @return true if transfer was successful
    */
    function transferEther(
        address payable _recipient, 
        uint _amount
    ) 
        public 
        returns (bool) 
    {
        uint balance = getBalance(); 

        require(balance >= _amount, 'Not enough Ether in contract!');
        _recipient.transfer(_amount);
        
        return true;
    }


    /**
    * @dev transferring _amount JPY to 
    * the _recipient address from the contract.
    * 
    * requires: enough balance
    * 
    * @return true if transfer was successful
    */
    function transferJpyEth(
        address payable _recipient,
        uint _amountInJpy
    )
        public
        returns (bool)
    {
        uint balance = getBalance();
        uint _amountInEth = getEthJpy(_amountInJpy) * 10 ** 10;

        require(balance >= _amountInEth, 'Not enough Ether in contract!');

        transferEther(_recipient, _amountInEth);
        
    }

}