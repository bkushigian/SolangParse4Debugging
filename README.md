# README

This crate provides a binary that invokes solang's parser and resolution:

```bash
solang_parser file1.sol file2.sol ... --import_paths path1 path2 ... --import_maps map1 map2 ...
```

and prints any errors encountered.


## Test Cases
I'm also cataloging test cases where solang fails.

### Overloaded Function Order Matters

This corresponds to [Issue 1534](https://github.com/hyperledger/solang/issues/1534).

Run:

```bash
solang_parser testcase/overloaded_order_matters/*.sol
```

which should output:

```
=====  Error: testcase/overload_order_matters/Overloaded3.sol  =====
error: function expects 1 arguments, 2 provided
   ┌─ testcase/overload_order_matters/Overloaded3.sol:12:23
   │
12 │         uint result = f(uint256(n), x);
   │                       ^^^^^^^^^^^^^^^^
```

indicating a bug.

### Override Errors
There are some errors with override lists. The following example, located in
`testcase/override_errors/ERC721.sol`, is a simplified version of
[OpenZeppelin's ERC721 contract](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol):

```solidity
// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.9.0) (token/ERC721/ERC721.sol)

pragma solidity ^0.8.19;

interface IERC165 {
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

abstract contract ERC165 is IERC165 {
    function supportsInterface(
        bytes4 interfaceId
    ) public view virtual returns (bool) {
        return interfaceId == type(IERC165).interfaceId;
    }
}

abstract contract ERC721 is ERC165 {
    function supportsInterface(
        bytes4 interfaceId
    ) public view virtual override(ERC165) returns (bool) {
        return interfaceId == interfaceId;
    }
}

```

This compiles with `solc`:

```
$ solc testcase/override_errors/ERC721.sol 
Compiler run successful. No output generated.
```

but `solang_parser` fails to parse it:

```
$ solang_parser testcase/override_errors/ERC721.sol 

=====  Error: testcase/override_errors/ERC721.sol  =====
error: function 'supportsInterface' missing overrides 'IERC165', specify 'override(IERC165,ERC165)'
   ┌─ testcase/override_errors/ERC721.sol:21:27
   │
21 │     ) public view virtual override(ERC165) returns (bool) {
   │                           ^^^^^^^^^^^^^^^^
```

Further, `solang_parser` suggests the fix, which I have stored in
`testcase/override_errors/ERC721_suggested_fix.sol`. `solc` failes to compile this:


```
$ solc testcase/override_errors/ERC721_suggested_fix.sol 
Error: Invalid contract specified in override list: "IERC165".
  --> testcase/override_errors/ERC721_suggested_fix.sol:21:27:
   |
21 |     ) public view virtual override(IERC165, ERC165) returns (bool) {
   |                           ^^^^^^^^^^^^^^^^^^^^^^^^^
Note: This contract: 
 --> testcase/override_errors/ERC721_suggested_fix.sol:6:1:
  |
6 | interface IERC165 {
  | ^ (Relevant source part starts here and spans across multiple lines).

```

but `solang_parser` successfully parses it.