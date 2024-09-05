// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    uint256 public usd = 230;
    AggregatorV3Interface internal dataFeed;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    constructor() {
        dataFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
    }

    function fund() public payable {
        require(getConvertionRate(msg.value) > usd, "error, must be 1eth");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function getVersion() public view returns (uint256) {
        AggregatorV3Interface chainVersion = dataFeed;
        return chainVersion.version();
    }

    function getPrice() public view returns (uint256) {
        (
            ,
            /* uint80 roundID */
            int256 answer, /*uint startedAt*/ /*uint timeStamp*/ /*uint80 answeredInRound*/
            ,
            ,

        ) = dataFeed.latestRoundData();
        // 2394.48970000
        answer * 1e10;
        return uint256(answer);
    }

    function getConvertionRate(uint256 ethPrice) public view returns (uint256) {
        uint256 usdPrice = getPrice();
        return (usdPrice * ethPrice) / 1e18;
    }
}
