// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConvertion {
    function getVersion() public view returns (uint256) {
        AggregatorV3Interface chainVersion = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        return chainVersion.version();
    }

    function getPrice() public view returns (uint256) {
        (
            ,
            /* uint80 roundID */
            int256 answer, /*uint startedAt*/ /*uint timeStamp*/ /*uint80 answeredInRound*/
            ,
            ,

        ) = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306)
                .latestRoundData();
        // 2394.48970000
        answer * 1e10;
        return uint256(answer);
    }

    function getConvertionRate(uint256 ethPrice) public view returns (uint256) {
        uint256 usdPrice = getPrice();
        return (usdPrice * ethPrice) / 1e18;
    }
}
