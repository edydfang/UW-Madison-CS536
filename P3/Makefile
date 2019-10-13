###
# This Makefile can be used to make a parser for the cflat language
# (parser.class) and to make a program (P3.class) that tests the parser and
# the unparse methods in ast.java.
#
# make clean removes all generated files.
#
###

JC = javac
FLAGS = -g  
CP = ./deps:.

P3.class: P3.java parser.class Yylex.class ASTnode.class
	$(JC) $(FLAGS) -cp $(CP) P3.java

parser.class: parser.java ASTnode.class Yylex.class ErrMsg.class
	$(JC) $(FLAGS) -cp $(CP) parser.java

parser.java: cflat.cup
	java -cp $(CP) java_cup.Main < cflat.cup

Yylex.class: cflat.jlex.java sym.class ErrMsg.class
	$(JC) $(FLAGS) -cp $(CP) cflat.jlex.java

ASTnode.class: ast.java
	$(JC) $(FLAGS) -cp $(CP) ast.java

cflat.jlex.java: cflat.jlex sym.class
	java -cp $(CP) JLex.Main cflat.jlex

sym.class: sym.java
	$(JC) $(FLAGS) -cp $(CP) sym.java

sym.java: cflat.cup
	java -cp $(CP) java_cup.Main < cflat.cup

ErrMsg.class: ErrMsg.java
	$(JC) $(FLAGS) -cp $(CP) ErrMsg.java

##test
test:P3.class
	java -cp $(CP) P3 test.cflat test.out

###
# clean
###
clean:
	rm -f *~ *.class parser.java cflat.jlex.java sym.java

## cleantest (delete test artifacts)
cleantest:
	rm -f *.out
