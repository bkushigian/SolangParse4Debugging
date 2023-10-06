// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.0) (utils/Strings.sol)

pragma solidity ^0.8.20;

contract StringConcat {
    function concat(
        string memory a,
        string memory b
    ) public pure returns (string memory) {
        return string.concat(a, b);
    }
}
