// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract SimpleStorage {
    uint256 public number;

    mapping(string => uint256) public stringToNumber;

    struct People {
        string name;
        uint256 number;
    }

    People[] public people;

    function addPeople(string memory _name, uint256 _number) public {
        people.push(People(_name, _number));
        stringToNumber[_name] = _number;
    }

    function store(uint256 _number) public virtual {
        number = _number;
    }

    function retrieve() public view returns (uint256) {
        return number;
    }
}
