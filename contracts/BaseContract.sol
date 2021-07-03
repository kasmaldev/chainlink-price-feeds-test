// SPDX-License-Identifier: MIT
pragma solidity 0.7.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract PriceConverter is Ownable {

    event Received(address, uint);
    /**
    * @notice contract can receive Ether.
    */
    receive() external payable {
        emit Received(msg.sender, msg.value);
	}

    function deposit() public payable {
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
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