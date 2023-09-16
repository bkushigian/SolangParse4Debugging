// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

contract AddressCode {
    function addressCode(address addr) public view returns (uint256) {
        return addr.code.length;
    }
}
