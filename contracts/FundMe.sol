// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "./PriceConvertion.sol";

contract FundMe {
    uint256 public constant USD = 100 * 1e18;
    using PriceConvertion for uint256;
    address public immutable i_owner;
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;
    uint256 public cek;
    error NotOwner();

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        cek = msg.value.getConvertionRate();
        require(cek > USD, "error, must be 100$");

        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public ownerTest {
        // mapping reset
        for (uint256 i = 0; i < funders.length; i++) {
            address funder = funders[i];
            addressToAmountFunded[funder] = 0;
        }

        // funders reset
        funders = new address[](0);

        // withdraw
        // transfer
        // payable(msg.sender).transfer(address(this).balance);

        // send
        // bool send = payable(msg.sender).send(address(this).balance);
        // require(send, "send reverted");

        // call
        (bool call, ) = payable(msg.sender).call{value: address(this).balance}(
            ""
        );
        require(call, "send reverted");
    }

    modifier ownerTest() {
        if (i_owner != msg.sender) {
            revert NotOwner();
        }
        // require(i_owner == msg.sender, "You're not the owner");
        _;
    }
}
