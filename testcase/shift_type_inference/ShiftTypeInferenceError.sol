// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity >=0.8.0;

contract MultiRolesAuthority {
    function shiftTypeInference(uint8 role) public virtual returns (bytes32) {
        bytes32 x = bytes32(1 << role);
        return x;
    }
}
