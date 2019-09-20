# Programming Assignment 01
In this assignment, we mainly implemented the SymbolTable class and its related testing and exceptions code for future use.

## How to build and run
```shell
javac *.java
java P1
```
## Specifications
Four Java classes: `SymTable`, `Sym`, `DuplicateSymException`, and `EmptySymTableException`. `P1.java` for babysitting testing.

The `SymTable` class will be used by the compiler written later to represent a symbol table: a data structure that stores the identifiers declared in the program being compiled (e.g., function and variable names) and information about each identifier (e.g., its type, where it will be stored at runtime). The symbol table will be implemented as a List of `HashMap`s. Eventually, each `HashMap` will store the identifiers declared in one scope in the program being compiled.

The HashMap keys will be Strings (the declared identifier names) and the associated information will be Syms (you will also implement the Sym class). For now, the only information in a Sym will be the type of the identifier, represented using a String (e.g., “int”, “double”, etc.).

The `DuplicateSymException` and `EmptySymTableException` classes will define exceptions that can be thrown by methods of the SymTable class.

In addition to defining the four classes, you will write a main program to test your implementation. You will be graded on the correctness of your Sym and SymTable classes, on how thoroughly you test the classes that you implement, on the efficiency of your code, and on your programming style.
