# Lexical Scanner for CFlat
Yidong Fang

In this project, we implemented the lexical scanner for the cflat language. 
`JLex` is used in order to automatically translate our regular expression and 
correspoing actions into Java token scanner code. The process inside the `JLex`
probabliy is `regular expression` -> `NFA(Mondeterministic Finite Automata)` ->
`DFA(Deterministic Finite Automata)` -> `DFA Table Simplification` -> 
`Java Looping Code`.

## Project Structure
```
.
├── sym.java - CUP generated class containing symbol constants.
├── cflat.jlex - working file to set rules of JLex
├── P2.java - working file to test our scanner code
├── Makefile - Makefile for build, test and clean
├── cflat.jlex.java - JLex genreated Scanner file, may not exsit before building
├── deps - dependency
│   ├── java_cup
│   └── JLex
├── ErrMsg.java - Java class to print lexical error
├── allInvalidToken.in - test cases for valid token
├── allInvalidToken.std - correct output of test cases for valid token
├── allValidToken.in - test cases for invalid token
├── allValidToken.std - correct output of test cases for invalid token
├── stringEOFcase0.in - test case for incomplete string literal with EOF
├── stringEOFcase1.in - test case for incomplete string literal with EOF
├── stringEOFcase2.in - test case for incomplete string literal with EOF
└── testStderr.std - correct stderr output of all test cases
```

## How to build and test
```shell
# build
make
# test
make test
# clean bin
make clean
# clean test output
make cleantest
```