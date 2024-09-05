// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "./PriceConvertion.sol";

contract FundMe {
    uint256 public usd = 230;
    using PriceConvertion for uint256;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable {
        require(msg.value.getConvertionRate() > usd, "error, must be 1eth");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }
}
