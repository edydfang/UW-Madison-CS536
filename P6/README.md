# Assembly Code Generator for the Cflat Compiler

Yidong Fang

In this project, a MIPS assembly generator is implemented for the Cflat language.
The final generator mainly support `int`, `bool` and `stringLit` in programs'
memory. Also, for the control flows, it supports function call, if-else statement
as well as while statement. Thus, in the test case a basic Fibonacci Recursive
Algorithm is implemented.

## How to build and test

The test input is in the `test.cflat`. The output assembly code is in the `test.s`.

```shell
# build
make
# test
make test
# run the assembly in the QSPIM
spim test.s
```