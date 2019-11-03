# Name Analyzer for the Abstruct Syntax Tree

Yidong Fang

In this project, we implemented the name analyzer for the parsed AST. The name 
anlyzer performs the following tasks: 1) Build symbol tables. 2) Find multiply 
declared names, uses of undeclared names, bad struct accesses, and bad 
declarations. 3) Add IdNode links so that show the Id type during unparsing.

## How to build and test

The test input is in the `test.cflat` and `nameErrors.cflat`. The unparsed 
result is in the `test.out` and `nameErrors.out`.

```shell
# build
make
# test
make test
```
