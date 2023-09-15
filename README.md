# README

This crate provides a binary that invokes solang's parser and resolution:

```bash
solang_parser file1.sol file2.sol ... --import_paths path1 path2 ... --import_maps map1 map2 ...
```

and prints any errors encountered.


## Test Cases
I'm also cataloging test cases where solang fails.

### Overloaded Function Order Matters

Run:

```bash
solang_parser testcase/overloaded_order_matters/*.sol
```

which should output:

```
=====  Error: testcase/overload_order_matters/Overloaded3.sol  =====
error: function expects 1 arguments, 2 provided
   ┌─ /Users/benku/solang_parse/testcase/overload_order_matters/Overloaded3.sol:12:23
   │
12 │         uint result = f(uint256(n), x);
   │                       ^^^^^^^^^^^^^^^^
```

indicating a bug.