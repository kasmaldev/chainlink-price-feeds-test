// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PriceConverter is Ownable {
    AggregatorV3Interface internal eth_usd_price_feed;
    AggregatorV3Interface internal jpy_usd_price_feed;

    constructor() {
        eth_usd_price_feed = AggregatorV3Interface(0x9326BFA02ADD2366b30bacB125260Af641031331);
        jpy_usd_price_feed = AggregatorV3Interface(0xD627B1eF3AC23F1d3e576FA6206126F3c1Bd0942);
    }

    /**
    * @notice contract can receive Ether.
    */
    receive() external payable {}

    function deposit() public payable {
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    /**
     * Returns the latest price
     */
    function getEthUsd() public view returns (int) {
        (
            , int price, , , 
        ) = eth_usd_price_feed.latestRoundData();

        return price;
    }


    function getJpyUsd() public view returns (int) {
        (
            , int price, , , 
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

    function withdraw() public onlyOwner {
        // get the amount of Ether stored in this contract
        uint amount = address(this).balance;

        // send all Ether to owner
        // Owner can receive Ether since the address of owner is payable
        (bool success,) = owner().call{value: amount}("");
        require(success, "Failed to send Ether");
    }

    // Function to transfer Ether from this contract to address from input
    function transfer(address payable _to, uint _amount) public onlyOwner {
        // Note that "to" is declared as payable
        (bool success,) = _to.call{value: _amount}("");
        require(success, "Failed to send Ether");
    }
}