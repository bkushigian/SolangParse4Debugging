// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

contract LiteralTypeInfer {
    function typeInfer() public pure returns (int256 x) {
        x = 5 ** 10;
    }
}
