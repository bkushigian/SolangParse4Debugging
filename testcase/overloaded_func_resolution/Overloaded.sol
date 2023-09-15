// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Overloaded {
    function f(uint n) internal pure returns (uint) {
        return n;
    }

    function f(uint v, int n, bool b) internal pure returns (int) {
        uint result = f(v, abs(n), b);
        return n > 0 ? int(result) : -int(result);
    }

    function f(uint v, uint n, bool b) internal pure returns (uint) {
        if (b) {
            return v + n;
        }

        return v + n;
    }

    function abs(int v) internal pure returns (uint) {
        return v >= 0 ? uint(v) : uint(-v);
    }
}
