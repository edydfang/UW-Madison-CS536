###
# This Makefile can be used to make a parser for the cflat language
# (parser.class) and to make a program (P4.class) that tests the parser, unparse and
# name analysis methods in ast.java.
#
# make clean removes all generated files.
#
###

JC = javac
FLAGS = -g  
CP = ./deps:.

P4.class: P4.java parser.class Yylex.class ASTnode.class
	$(JC) $(FLAGS) -cp $(CP) P4.java

parser.class: parser.java ASTnode.class Yylex.class ErrMsg.class
	$(JC) $(FLAGS) -cp $(CP) parser.java

parser.java: cflat.cup
	java -cp $(CP) java_cup.Main < cflat.cup

Yylex.class: cflat.jlex.java sym.class ErrMsg.class
	$(JC) $(FLAGS) -cp $(CP) cflat.jlex.java

ASTnode.class: ast.java SymTable.class
	$(JC) $(FLAGS) -cp $(CP) ast.java

cflat.jlex.java: cflat.jlex sym.class
	java -cp $(CP) JLex.Main cflat.jlex

sym.class: sym.java
	$(JC) $(FLAGS) -cp $(CP) sym.java

sym.java: cflat.cup
	java -cp $(CP) java_cup.Main < cflat.cup

ErrMsg.class: ErrMsg.java
	$(JC) $(FLAGS) -cp $(CP) ErrMsg.java

Sym.class: Sym.java
	$(JC) $(FLAGS) -cp $(CP) Sym.java

SymTable.class: SymTable.java Sym.class DuplicateSymException.class WrongArgumentException.class EmptySymTableException.class
	$(JC) $(FLAGS) -cp $(CP) SymTable.java

DuplicateSymException.class: DuplicateSymException.java
	$(JC) $(FLAGS) -cp $(CP) DuplicateSymException.java

WrongArgumentException.class: WrongArgumentException.java
	$(JC) $(FLAGS) -cp $(CP) WrongArgumentException.java

EmptySymTableException.class: EmptySymTableException.java
	$(JC) $(FLAGS) -cp $(CP) EmptySymTableException.java

##test
test: P4.class
	java -cp $(CP) P4 nameErrors.cflat nameErrors.out
	java -cp $(CP) P4 test.cflat test.out

###
# clean
###
clean:
	rm -f *~ *.class parser.java cflat.jlex.java sym.java

## cleantest (delete test artifacts)
cleantest:
	rm -f *.out
