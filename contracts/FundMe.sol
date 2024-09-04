// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    uint256 public number;

    function fund() public payable {
        number = 5;
        require(msg.value > 1e18, "error, must be 1eth");
    }

    function getVersion() public view returns (uint256) {
        AggregatorV3Interface chainVersion = AggregatorV3Interface(
            0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
        );
        return chainVersion.version();
    }
}
