# Parser Generating and Abstruct Syntax Tree Building

Yidong Fang

In this project, we implemented the parser to parse the code into an intermediate 
representation, i.e. `AST`. We use one Java parser generator (`CUP`) to automatically
generate the parser according to our Context Free Grammer Definition and the 
corresponding actions for production rules. To be more specific, `CUP` can only 
generate parsers for `LALR(1)` grammar. 

The whole process now is 

- JAVA CUP: Grammer Defination for CUP `cflat.cup` -> `sym.java`, `parser.java`
- JLex: Token Scanner Defination for Jlex `cflat.jlex` + `sym.class` -> `cflat.jlex.java`
- `cflat.jlex.java` + `sym.class` + `ErrMsg.class` -> `Yylex.class`
- `ASTnode.class` + `Yylex.class` + `ErrMsg.class` + `parser.java` -> `parser.class`

## How to build and test

The test input is in the `test.cflat`. The unparsed result is in the `test.out`.

```shell
# build
make
# test
make test
```
