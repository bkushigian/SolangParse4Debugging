// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.0) (token/ERC721/ERC721.sol)

pragma solidity ^0.8.19;

import {IERC721} from "./IERC721.sol";
import {ERC165} from "./ERC165.sol";

abstract contract ERC721 is ERC165 {
    function supportsInterface(
        bytes4 interfaceId
    ) public view virtual override(ERC165) returns (bool) {
        return interfaceId == interfaceId;
    }
}
