###
#
# make clean removes all generated files.
#
###

JC = javac

CP = ./deps:.

P6.class: P6.java parser.class Yylex.class ASTnode.class
	$(JC) -g -cp $(CP) P6.java

parser.class: parser.java ASTnode.class Yylex.class ErrMsg.class
	$(JC) -g -cp $(CP) parser.java

parser.java: cflat.cup
	java -cp $(CP) java_cup.Main < cflat.cup

Yylex.class: cflat.jlex.java sym.class ErrMsg.class
	$(JC) -g -cp $(CP) cflat.jlex.java

ASTnode.class: ast.java Type.java Sym.class
	$(JC) -g -cp $(CP) ast.java Type.java

cflat.jlex.java: cflat.jlex sym.class
	java -cp $(CP) JLex.Main cflat.jlex

sym.class: sym.java
	$(JC) -g -cp $(CP) sym.java

sym.java: cflat.cup
	java java_cup.Main < cflat.cup

ErrMsg.class: ErrMsg.java
	$(JC) -g -cp $(CP) ErrMsg.java

Sym.class: Sym.java Type.class ast.java
	$(JC) -g -cp $(CP) Sym.java ast.java

SymTable.class: SymTable.java Sym.class DuplicateSymException.class EmptySymTableException.class WrongArgumentException.class
	$(JC) -g -cp $(CP) SymTable.java

Type.class: Type.java ast.java Sym.java
	$(JC) -g -cp $(CP) Type.java ast.java Sym.java

WrongArgumentException.class: WrongArgumentException.java
	$(JC) -g -cp $(CP) WrongArgumentException.java

DuplicateSymException.class: DuplicateSymException.java
	$(JC) -g -cp $(CP) DuplicateSymException.java

EmptySymTableException.class: EmptySymTableException.java
	$(JC) -g -cp $(CP) EmptySymTableException.java

###
# test
#
test:
	java -cp $(CP) P6 test.cflat test.s

###
# clean
###
clean:
	rm -f *~ *.class parser.java cflat.jlex.java sym.java

cleantest:
	rm -f test.s
