// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "@chainlink/contracts/src/v0.8/interfaces/FeedRegistryInterface.sol";
import "@chainlink/contracts/src/v0.8/dev/Denominations.sol";
import "@openzeppelin/contracts/utils/math/SafeCast.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract PriceConsumer {
    using SafeCast for int256;
    using SafeMath for uint256;

    FeedRegistryInterface internal registry;

    /**
     * Network: Mainnet Alpha Preview
     * Feed Registry: 0xd441F0B98BcF34749391A3879A94caA95ffDB74D
     */
    constructor() {
        registry = FeedRegistryInterface(0xd441F0B98BcF34749391A3879A94caA95ffDB74D);
    }

    /**
     * Returns the latest price
     */
    function getThePrice(address asset, address denomination) public view returns (uint) {
        (
            , int price, , , 
        ) = registry.latestRoundData(asset, denomination);
        return price.toUint256();
    }

}