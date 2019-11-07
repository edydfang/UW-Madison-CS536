import java.io.*;
import java.util.*;

// **********************************************************************
// The ASTnode class defines the nodes of the abstract-syntax tree that
// represents a cflat program.
//
// Internal nodes of the tree contain pointers to children, organized
// either in a list (for nodes that may have a variable number of 
// children) or as a fixed set of fields.
//
// The nodes for literals and ids contain line and character number
// information; for string literals and identifiers, they also contain a
// string; for integer literals, they also contain an integer value.
//
// Here are all the different kinds of AST nodes and what kinds of children
// they have.  All of these kinds of AST nodes are subclasses of "ASTnode".
// Indentation indicates further subclassing:
//
//     Subclass            Kids
//     --------            ----
//     ProgramNode         DeclListNode
//     DeclListNode        linked list of DeclNode
//     DeclNode:
//       VarDeclNode       TypeNode, IdNode, int
//       FnDeclNode        TypeNode, IdNode, FormalsListNode, FnBodyNode
//       FormalDeclNode    TypeNode, IdNode
//       StructDeclNode    IdNode, DeclListNode
//
//     FormalsListNode     linked list of FormalDeclNode
//     FnBodyNode          DeclListNode, StmtListNode
//     StmtListNode        linked list of StmtNode
//     ExpListNode         linked list of ExpNode
//
//     TypeNode:
//       IntNode           -- none --
//       BoolNode          -- none --
//       VoidNode          -- none --
//       StructNode        IdNode
//
//     StmtNode:
//       AssignStmtNode      AssignNode
//       PostIncStmtNode     ExpNode
//       PostDecStmtNode     ExpNode
//       ReadStmtNode        ExpNode
//       WriteStmtNode       ExpNode
//       IfStmtNode          ExpNode, DeclListNode, StmtListNode
//       IfElseStmtNode      ExpNode, DeclListNode, StmtListNode,
//                                    DeclListNode, StmtListNode
//       WhileStmtNode       ExpNode, DeclListNode, StmtListNode
//       RepeatStmtNode      ExpNode, DeclListNode, StmtListNode
//       CallStmtNode        CallExpNode
//       ReturnStmtNode      ExpNode
//
//     ExpNode:
//       IntLitNode          -- none --
//       StrLitNode          -- none --
//       TrueNode            -- none --
//       FalseNode           -- none --
//       IdNode              -- none --
//       DotAccessNode       ExpNode, IdNode
//       AssignNode          ExpNode, ExpNode
//       CallExpNode         IdNode, ExpListNode
//       UnaryExpNode        ExpNode
//         UnaryMinusNode
//         NotNode
//       BinaryExpNode       ExpNode ExpNode
//         PlusNode     
//         MinusNode
//         TimesNode
//         DivideNode
//         AndNode
//         OrNode
//         EqualsNode
//         NotEqualsNode
//         LessNode
//         GreaterNode
//         LessEqNode
//         GreaterEqNode
//
// Here are the different kinds of AST nodes again, organized according to
// whether they are leaves, internal nodes with linked lists of kids, or
// internal nodes with a fixed number of kids:
//
// (1) Leaf nodes:
//        IntNode,   BoolNode,  VoidNode,  IntLitNode,  StrLitNode,
//        TrueNode,  FalseNode, IdNode
//
// (2) Internal nodes with (possibly empty) linked lists of children:
//        DeclListNode, FormalsListNode, StmtListNode, ExpListNode
//
// (3) Internal nodes with fixed numbers of kids:
//        ProgramNode,     VarDeclNode,     FnDeclNode,     FormalDeclNode,
//        StructDeclNode,  FnBodyNode,      StructNode,     AssignStmtNode,
//        PostIncStmtNode, PostDecStmtNode, ReadStmtNode,   WriteStmtNode   
//        IfStmtNode,      IfElseStmtNode,  WhileStmtNode,  RepeatStmtNode,
//        CallStmtNode
//        ReturnStmtNode,  DotAccessNode,   AssignExpNode,  CallExpNode,
//        UnaryExpNode,    BinaryExpNode,   UnaryMinusNode, NotNode,
//        PlusNode,        MinusNode,       TimesNode,      DivideNode,
//        AndNode,         OrNode,          EqualsNode,     NotEqualsNode,
//        LessNode,        GreaterNode,     LessEqNode,     GreaterEqNode
//
// **********************************************************************

// **********************************************************************
// <<<ASTnode class (base class for all other kinds of nodes)>>>
// **********************************************************************

abstract class ASTnode { 
    // every subclass must provide an unparse operation
    abstract public void unparse(PrintWriter p, int indent);

    // this method can be used by the unparse methods to do indenting
    protected void addIndent(PrintWriter p, int indent) {
        for (int k = 0; k < indent; k++) p.print(" ");
    }
}

// **********************************************************************
// <<<ProgramNode,  DeclListNode, FormalsListNode, FnBodyNode,
// StmtListNode, ExpListNode>>>
// **********************************************************************

class ProgramNode extends ASTnode {
    public ProgramNode(DeclListNode L) {
        myDeclList = L;
    }

    public void unparse(PrintWriter p, int indent) {
        myDeclList.unparse(p, indent);
    }
    public void nameAnalyze(){
        SymTable symTable = new SymTable();
        myDeclList.nameAnalyze(symTable);
    }
    // 1 kid
    private DeclListNode myDeclList;
}

class DeclListNode extends ASTnode {
    public DeclListNode(List<DeclNode> S) {
        myDecls = S;
    }

    public void unparse(PrintWriter p, int indent) {
        Iterator<DeclNode> it = myDecls.iterator();
        try {
            while (it.hasNext()) {
                ((DeclNode)it.next()).unparse(p, indent);
            }
        } catch (NoSuchElementException ex) {
            System.err.println("unexpected NoSuchElementException in DeclListNode.print");
            System.exit(-1);
        }
    }
    // method for fnbody
    public SymTable nameAnalyzeFnBody(SymTable symTable){
        HashMap<String, Integer> occurance = new HashMap<>(); 
        for (DeclNode declNode : myDecls) {
            IdNode idNode = declNode.getIdNode();
            String name = idNode.toString();
            occurance.put(name, occurance.getOrDefault(name, 0)+1);
            if(occurance.get(name)==1 && symTable.lookupLocal(name)==null){
                // first time in body and not in formlist
                declNode.nameAnalyze(symTable);
            }
            if(occurance.get(name)>1){
                // occurance twice in the body
                ErrMsg.fatal(idNode.getLineNum(), idNode.getCharNum(), 
                "Multiply declared identifier");
            }
            
        }
        return symTable;
    }
    public SymTable nameAnalyze(SymTable symTable){
        for (DeclNode declNode : myDecls) {
            declNode.nameAnalyze(symTable);
        }
        return symTable;
    }
    // method for structdecl
    public SymTable nameAnalyze(SymTable symTable, SymTable structSymTable){
        for (DeclNode declNode : myDecls) {
            VarDeclNode node = (VarDeclNode) declNode;
            if(node.getSize() == VarDeclNode.NOT_STRUCT){
                node.nameAnalyze(structSymTable);
            }else{
                node.nameAnalyzeStruct(symTable, structSymTable);
            }
        }
        return symTable;
    }

    // list of kids (DeclNodes)
    private List<DeclNode> myDecls;
}

class FormalsListNode extends ASTnode {
    public FormalsListNode(List<FormalDeclNode> S) {
        myFormals = S;
    }

    public void unparse(PrintWriter p, int indent) {
        Iterator<FormalDeclNode> it = myFormals.iterator();
        if (it.hasNext()) { // if there is at least one element
            it.next().unparse(p, indent);
            while (it.hasNext()) {  // print the rest of the list
                p.print(", ");
                it.next().unparse(p, indent);
            }
        } 
    }
    public LinkedList<String> getTypeList(){
        LinkedList<String> paramTypes = new LinkedList<>();
        for (FormalDeclNode formalDeclNode : myFormals) {
            paramTypes.add(formalDeclNode.getTypeString());
        }
        return paramTypes;
    }

    public SymTable nameAnalyze(SymTable symTable) {
        for (FormalDeclNode formalDeclNode : myFormals) {
            formalDeclNode.nameAnalyze(symTable);
        }
        return symTable;
    }

    // list of kids (FormalDeclNodes)
    private List<FormalDeclNode> myFormals;
}

class FnBodyNode extends ASTnode {
    public FnBodyNode(DeclListNode declList, StmtListNode stmtList) {
        myDeclList = declList;
        myStmtList = stmtList;
    }

    public void unparse(PrintWriter p, int indent) {
        myDeclList.unparse(p, indent);
        myStmtList.unparse(p, indent);
    }
    public void nameAnalyze(SymTable symTable){
        myDeclList.nameAnalyzeFnBody(symTable);
        myStmtList.nameAnalyze(symTable);
    }
    // 2 kids
    private DeclListNode myDeclList;
    private StmtListNode myStmtList;
}

class StmtListNode extends ASTnode {
    public StmtListNode(List<StmtNode> S) {
        myStmts = S;
    }

    public void unparse(PrintWriter p, int indent) {
        Iterator<StmtNode> it = myStmts.iterator();
        while (it.hasNext()) {
            it.next().unparse(p, indent);
        }
    }
    public void nameAnalyze(SymTable symTable){
        for (StmtNode stmtNode : myStmts) {
            stmtNode.nameAnalyze(symTable);
        }
    }
    // list of kids (StmtNodes)
    private List<StmtNode> myStmts;
}

class ExpListNode extends ASTnode {
    public ExpListNode(List<ExpNode> S) {
        myExps = S;
    }

    public void unparse(PrintWriter p, int indent) {
        Iterator<ExpNode> it = myExps.iterator();
        if (it.hasNext()) { // if there is at least one element
            it.next().unparse(p, indent);
            while (it.hasNext()) {  // print the rest of the list
                p.print(", ");
                it.next().unparse(p, indent);
            }
        } 
    }
    public void nameAnalyze(SymTable symTable){
        for (ExpNode expNode : myExps) {
            expNode.nameAnalyze(symTable);
        }
    }
    // list of kids (ExpNodes)
    private List<ExpNode> myExps;
}

// **********************************************************************
// <<<DeclNode and its subclasses>>>
// **********************************************************************

abstract class DeclNode extends ASTnode {
    abstract public SymTable nameAnalyze(SymTable symtable);
    abstract public IdNode getIdNode();
}

class VarDeclNode extends DeclNode {
    public VarDeclNode(TypeNode type, IdNode id, int size) {
        myType = type;
        myId = id;
        mySize = size;
    }

    public void unparse(PrintWriter p, int indent) {
        addIndent(p, indent);
        myType.unparse(p, 0);
        p.print(" ");
        myId.unparse(p, 0);
        p.println(";");
    }
    // normal var declaration
    public SymTable nameAnalyze(SymTable symTable){
        if (myType instanceof VoidNode) {
            ErrMsg.fatal(this.myId.getLineNum(), this.myId.getCharNum(), 
            "Non-function declared void");
	    return symTable;
        }
        if (myType instanceof StructNode) {
            boolean result = this.nameAnalyzeStructName(symTable);
            Sym structSym = symTable.lookupGlobal(((StructNode)myType).getId().toString());
	    if(structSym == null || result == false){
	    	return symTable;
	    }
            this.nameAnalyzeVarName(symTable);
            Sym mySym = symTable.lookupGlobal(myId.toString());
            myId.setStruct(structSym.getStruct(), mySym); 
	    return symTable;
        }
        this.nameAnalyzeVarName(symTable);
        return symTable;
    }
    // var name checking
    public void nameAnalyzeVarName(SymTable symTable){
        Sym newSym = new Sym(this.myType.toString());
        // myId.setSym(newSym);
        try{
            symTable.addDecl(this.myId.toString(), newSym);
        } catch  (DuplicateSymException ex){
            ErrMsg.fatal(this.myId.getLineNum(), this.myId.getCharNum(), 
            "Multiply declared identifier");
        } catch (EmptySymTableException ex) {
            System.out.println(ex);
        } catch (WrongArgumentException ex) {
            System.out.println(ex);
        }
        return;
    }
    // struct declration checking
    public void nameAnalyzeStruct(SymTable symTable, SymTable symTableStruct) {
        this.nameAnalyzeVarName(symTableStruct);
        this.nameAnalyzeStructName(symTable);
        if (myType instanceof StructNode) {
            Sym structSym = symTable.lookupGlobal(((StructNode)myType).getId().toString());
            Sym mySym = symTableStruct.lookupGlobal(myId.toString());
            if(structSym!=null && mySym != null){
                myId.setStruct(structSym.getStruct(), mySym); 
            }
        }
    }
    // only when it is struct decl
    public boolean nameAnalyzeStructName(SymTable symTable){
        IdNode structId = ((StructNode)this.myType).getId();
        Sym sym = symTable.lookupGlobal(structId.toString());
        if(sym == null || !sym.getType().equals("struct-decl")) {
            ErrMsg.fatal(structId.getLineNum(), structId.getCharNum(), 
            "Invalid name of struct type");
	    return false;
        }
        return true;
    }
    public int getSize(){
        return mySize;
    }
    public IdNode getIdNode() {
        return this.myId;
    }

    // 3 kids
    private TypeNode myType;
    private IdNode myId;
    private int mySize;  // use value NOT_STRUCT if this is not a struct type

    public static int NOT_STRUCT = -1;
}

class FnDeclNode extends DeclNode {
    public FnDeclNode(TypeNode type,
                      IdNode id,
                      FormalsListNode formalList,
                      FnBodyNode body) {
        myType = type;
        myId = id;
        myFormalsList = formalList;
        myBody = body;
    }

    public void unparse(PrintWriter p, int indent) {
        addIndent(p, indent);
        myType.unparse(p, 0);
        p.print(" ");
        myId.unparse(p, 0);
        p.print("(");
        myFormalsList.unparse(p, 0);
        p.println(") {");
        myBody.unparse(p, indent+4);
        p.println("}\n");
    }

    public SymTable nameAnalyze(SymTable symTable){
        LinkedList<String> paramTypes = myFormalsList.getTypeList();
        try{
            symTable.addDecl(this.myId.toString(), new FuncSym(myType.toString(), paramTypes));
        } catch  (DuplicateSymException ex){
            ErrMsg.fatal(this.myId.getLineNum(), this.myId.getCharNum(), 
            "Multiply declared identifier");
        } catch (EmptySymTableException ex) {
            System.out.println(ex);
        } catch (WrongArgumentException ex) {
            System.out.println(ex);
        }
        symTable.addScope();
        myFormalsList.nameAnalyze(symTable);
        myBody.nameAnalyze(symTable);
        try{
            symTable.removeScope();
        } catch (EmptySymTableException ex) {
            System.out.println(ex);
        }
        return symTable;
    }
    public IdNode getIdNode(){
        return this.myId;
    }
    // 4 kids
    private TypeNode myType;
    private IdNode myId;
    private FormalsListNode myFormalsList;
    private FnBodyNode myBody;
    // private SymTable mySymTable;
}

class FormalDeclNode extends DeclNode {
    public FormalDeclNode(TypeNode type, IdNode id) {
        myType = type;
        myId = id;
    }

    public void unparse(PrintWriter p, int indent) {
        myType.unparse(p, 0);
        p.print(" ");
        myId.unparse(p, 0);
    }
    public SymTable nameAnalyze(SymTable symTable){
        try{
            symTable.addDecl(this.myId.toString(), new Sym(this.myType.toString()));
        } catch  (DuplicateSymException ex){
            ErrMsg.fatal(this.myId.getLineNum(), this.myId.getCharNum(), 
            "Multiply declared identifier");
        } catch (EmptySymTableException ex) {
            System.out.println(ex);
        } catch (WrongArgumentException ex) {
            System.out.println(ex);
        }
        return symTable;
    }
    public String getTypeString(){
        return myType.toString();
    }
    public IdNode getIdNode() {
        return this.myId;
    }
    // 2 kids
    private TypeNode myType;
    private IdNode myId;
}

class StructDeclNode extends DeclNode {
    public StructDeclNode(IdNode id, DeclListNode declList) {
        myId = id;
        myDeclList = declList;
    }

    public void unparse(PrintWriter p, int indent) {
        addIndent(p, indent);
        p.print("struct ");
        myId.unparse(p, 0);
        p.println("{");
        myDeclList.unparse(p, indent+4);
        addIndent(p, indent);
        p.println("};\n");

    }
    public SymTable nameAnalyze(SymTable symTable){
        Sym newSym = new Sym("struct-decl");
        
        try{
            symTable.addDecl(this.myId.toString(), newSym);
        } catch  (DuplicateSymException ex){
            ErrMsg.fatal(this.myId.getLineNum(), this.myId.getCharNum(), 
            "Multiply declared identifier");
            return symTable;
        } catch (EmptySymTableException ex) {
            System.out.println(ex);
        } catch (WrongArgumentException ex) {
            System.out.println(ex);
        }
        mySymTable = new SymTable();
        // myId.setSym(newSym);
        myId.setStruct(this, newSym);
        // System.out.println(this);
        myDeclList.nameAnalyze(symTable, mySymTable);
        return symTable;
    }

    public SymTable getSymTable(){
        return mySymTable;
    }
    public IdNode getIdNode() {
        return this.myId;
    }
    // 2 kids
    private IdNode myId;
    private DeclListNode myDeclList;
    private SymTable mySymTable;
}

// **********************************************************************
// <<<TypeNode and its Subclasses>>>
// **********************************************************************

abstract class TypeNode extends ASTnode {
}

class IntNode extends TypeNode {
    public IntNode() {
    }

    public void unparse(PrintWriter p, int indent) {
        p.print("int");
    }
    public String toString(){
        return "int";
    }
}

class BoolNode extends TypeNode {
    public BoolNode() {
    }

    public void unparse(PrintWriter p, int indent) {
        p.print("bool");
    }
    public String toString(){
        return "bool";
    }
}

class VoidNode extends TypeNode {
    public VoidNode() {
    }

    public void unparse(PrintWriter p, int indent) {
        p.print("void");
    }
    public String toString(){
        return "void";
    }
}

class StructNode extends TypeNode {
    public StructNode(IdNode id) {
        myId = id;
    }

    public void unparse(PrintWriter p, int indent) {
        p.print("struct ");
        myId.unparse(p, 0);
    }
    public String toString(){
        return myId.toString();
    }

    public IdNode getId(){
        return myId;
    }
    // 1 kid
    private IdNode myId;
}

// **********************************************************************
// <<<StmtNode and its subclasses>>>
// **********************************************************************

abstract class StmtNode extends ASTnode {
    public abstract void nameAnalyze(SymTable symTable);
}

class AssignStmtNode extends StmtNode {
    public AssignStmtNode(AssignNode assign) {
        myAssign = assign;
    }

    public void unparse(PrintWriter p, int indent) {
        addIndent(p, indent);
        myAssign.unparse(p, -1); // no parentheses
        p.println(";");
    }
    public void nameAnalyze(SymTable symTable){
        myAssign.nameAnalyze(symTable);
    }
    // 1 kid
    private AssignNode myAssign;
}

class PostIncStmtNode extends StmtNode {
    public PostIncStmtNode(ExpNode exp) {
        myExp = exp;
    }

    public void unparse(PrintWriter p, int indent) {
        addIndent(p, indent);
        myExp.unparse(p, 0);
        p.println("++;");
    }
    public void nameAnalyze(SymTable symTable){
        myExp.nameAnalyze(symTable);
    }
    // 1 kid
    private ExpNode myExp;
}

class PostDecStmtNode extends StmtNode {
    public PostDecStmtNode(ExpNode exp) {
        myExp = exp;
    }

    public void unparse(PrintWriter p, int indent) {
        addIndent(p, indent);
        myExp.unparse(p, 0);
        p.println("--;");
    }
    public void nameAnalyze(SymTable symTable){
        myExp.nameAnalyze(symTable);
    }
    // 1 kid
    private ExpNode myExp;
}

class ReadStmtNode extends StmtNode {
    public ReadStmtNode(ExpNode e) {
        myExp = e;
    }

    public void unparse(PrintWriter p, int indent) {
        addIndent(p, indent);
        p.print("cin >> ");
        myExp.unparse(p, 0);
        p.println(";");
    }
    public void nameAnalyze(SymTable symTable){
        myExp.nameAnalyze(symTable);
    }
    // 1 kid (actually can only be an IdNode or an ArrayExpNode)
    private ExpNode myExp;
}

class WriteStmtNode extends StmtNode {
    public WriteStmtNode(ExpNode exp) {
        myExp = exp;
    }

    public void unparse(PrintWriter p, int indent) {
        addIndent(p, indent);
        p.print("cout << ");
        myExp.unparse(p, 0);
        p.println(";");
    }
    public void nameAnalyze(SymTable symTable){
        myExp.nameAnalyze(symTable);
    }
    // 1 kid
    private ExpNode myExp;
}

class IfStmtNode extends StmtNode {
    public IfStmtNode(ExpNode exp, DeclListNode dlist, StmtListNode slist) {
        myDeclList = dlist;
        myExp = exp;
        myStmtList = slist;
    }

    public void unparse(PrintWriter p, int indent) {
        addIndent(p, indent);
        p.print("if (");
        myExp.unparse(p, 0);
        p.println(") {");
        myDeclList.unparse(p, indent+4);
        myStmtList.unparse(p, indent+4);
        addIndent(p, indent);
        p.println("}");
    }
    public void nameAnalyze(SymTable symTable){
        myExp.nameAnalyze(symTable);
        symTable.addScope();
        myDeclList.nameAnalyze(symTable);
        myStmtList.nameAnalyze(symTable);
        try{
            symTable.removeScope();
        } catch (EmptySymTableException ex) {
            System.out.println(ex);
        }
    }
    // e kids
    private ExpNode myExp;
    private DeclListNode myDeclList;
    private StmtListNode myStmtList;
}

class IfElseStmtNode extends StmtNode {
    public IfElseStmtNode(ExpNode exp, DeclListNode dlist1,
                          StmtListNode slist1, DeclListNode dlist2,
                          StmtListNode slist2) {
        myExp = exp;
        myThenDeclList = dlist1;
        myThenStmtList = slist1;
        myElseDeclList = dlist2;
        myElseStmtList = slist2;
    }

    public void unparse(PrintWriter p, int indent) {
        addIndent(p, indent);
        p.print("if (");
        myExp.unparse(p, 0);
        p.println(") {");
        myThenDeclList.unparse(p, indent+4);
        myThenStmtList.unparse(p, indent+4);
        addIndent(p, indent);
        p.println("}");
        addIndent(p, indent);
        p.println("else {");
        myElseDeclList.unparse(p, indent+4);
        myElseStmtList.unparse(p, indent+4);
        addIndent(p, indent);
        p.println("}");        
    }
    public void nameAnalyze(SymTable symTable){
        myExp.nameAnalyze(symTable);
        symTable.addScope();
        myThenDeclList.nameAnalyze(symTable);
        myThenStmtList.nameAnalyze(symTable);
        try{
            symTable.removeScope();
        } catch (EmptySymTableException ex) {
            System.out.println(ex);
        }
        symTable.addScope();
        myThenDeclList.nameAnalyze(symTable);
        myElseStmtList.nameAnalyze(symTable);
        try{
            symTable.removeScope();
        } catch (EmptySymTableException ex) {
            System.out.println(ex);
        }
    }
    // 5 kids
    private ExpNode myExp;
    private DeclListNode myThenDeclList;
    private StmtListNode myThenStmtList;
    private StmtListNode myElseStmtList;
    private DeclListNode myElseDeclList;
}

class WhileStmtNode extends StmtNode {
    public WhileStmtNode(ExpNode exp, DeclListNode dlist, StmtListNode slist) {
        myExp = exp;
        myDeclList = dlist;
        myStmtList = slist;
    }
    
    public void unparse(PrintWriter p, int indent) {
        addIndent(p, indent);
        p.print("while (");
        myExp.unparse(p, 0);
        p.println(") {");
        myDeclList.unparse(p, indent+4);
        myStmtList.unparse(p, indent+4);
        addIndent(p, indent);
        p.println("}");
    }
    public void nameAnalyze(SymTable symTable){
        myExp.nameAnalyze(symTable);
        symTable.addScope();
        myDeclList.nameAnalyze(symTable);
        myStmtList.nameAnalyze(symTable);
        try{
            symTable.removeScope();
        } catch (EmptySymTableException ex) {
            System.out.println(ex);
        }
    }
    // 3 kids
    private ExpNode myExp;
    private DeclListNode myDeclList;
    private StmtListNode myStmtList;
}

class RepeatStmtNode extends StmtNode {
    public RepeatStmtNode(ExpNode exp, DeclListNode dlist, StmtListNode slist) {
        myExp = exp;
        myDeclList = dlist;
        myStmtList = slist;
    }
	
    public void unparse(PrintWriter p, int indent) {
	addIndent(p, indent);
        p.print("repeat (");
        myExp.unparse(p, 0);
        p.println(") {");
        myDeclList.unparse(p, indent+4);
        myStmtList.unparse(p, indent+4);
        addIndent(p, indent);
        p.println("}");
    }
    public void nameAnalyze(SymTable symTable){
        myExp.nameAnalyze(symTable);
        symTable.addScope();
        myDeclList.nameAnalyze(symTable);
        myStmtList.nameAnalyze(symTable);
        try{
            symTable.removeScope();
        } catch (EmptySymTableException ex) {
            System.out.println(ex);
        }
    }
    // 3 kids
    private ExpNode myExp;
    private DeclListNode myDeclList;
    private StmtListNode myStmtList;
}

class CallStmtNode extends StmtNode {
    public CallStmtNode(CallExpNode call) {
        myCall = call;
    }

    public void unparse(PrintWriter p, int indent) {
        addIndent(p, indent);
        myCall.unparse(p, indent);
        p.println(";");
    }
    public void nameAnalyze(SymTable symTable){
        myCall.nameAnalyze(symTable);
    }
    // 1 kid
    private CallExpNode myCall;
}

class ReturnStmtNode extends StmtNode {
    public ReturnStmtNode(ExpNode exp) {
        myExp = exp;
    }

    public void unparse(PrintWriter p, int indent) {
        addIndent(p, indent);
        p.print("return");
        if (myExp != null) {
            p.print(" ");
            myExp.unparse(p, 0);
        }
        p.println(";");
    }
    public void nameAnalyze(SymTable symTable){
        if(myExp!=null) {
            myExp.nameAnalyze(symTable);
        }
    }
    // 1 kid
    private ExpNode myExp; // possibly null
}

// **********************************************************************
// <<<ExpNode and its subclasses>>>
// **********************************************************************

abstract class ExpNode extends ASTnode {
    public abstract void nameAnalyze(SymTable symTable);
}

class IntLitNode extends ExpNode {
    public IntLitNode(int lineNum, int charNum, int intVal) {
        myLineNum = lineNum;
        myCharNum = charNum;
        myIntVal = intVal;
    }

    public void unparse(PrintWriter p, int indent) {
        p.print(myIntVal);
    }
    public void nameAnalyze(SymTable symTable){}
    private int myLineNum;
    private int myCharNum;
    private int myIntVal;
}

class StringLitNode extends ExpNode {
    public StringLitNode(int lineNum, int charNum, String strVal) {
        myLineNum = lineNum;
        myCharNum = charNum;
        myStrVal = strVal;
    }

    public void unparse(PrintWriter p, int indent) {
        p.print(myStrVal);
    }
    public void nameAnalyze(SymTable symTable){}
    private int myLineNum;
    private int myCharNum;
    private String myStrVal;
}

class TrueNode extends ExpNode {
    public TrueNode(int lineNum, int charNum) {
        myLineNum = lineNum;
        myCharNum = charNum;
    }

    public void unparse(PrintWriter p, int indent) {
        p.print("true");
    }
    public void nameAnalyze(SymTable symTable){}
    private int myLineNum;
    private int myCharNum;
}

class FalseNode extends ExpNode {
    public FalseNode(int lineNum, int charNum) {
        myLineNum = lineNum;
        myCharNum = charNum;
    }

    public void unparse(PrintWriter p, int indent) {
        p.print("false");
    }
    public void nameAnalyze(SymTable symTable){}
    private int myLineNum;
    private int myCharNum;
}

class IdNode extends ExpNode {
    public IdNode(int lineNum, int charNum, String strVal) {
        myLineNum = lineNum;
        myCharNum = charNum;
        myStrVal = strVal;
    }

    public void unparse(PrintWriter p, int indent) {
        p.print(myStrVal);
        if(mySym!=null){
            p.print("(");
            p.print(mySym.toString());
            p.print(")");
        }
        
    }

    public int getLineNum(){
        return myLineNum;
    }
    public int getCharNum(){
        return myCharNum;
    }
    public String toString(){
        return myStrVal;
    }
    public void nameAnalyze(SymTable symTable){
        this.mySym = symTable.lookupGlobal(myStrVal);
        if(mySym == null){
            ErrMsg.fatal(myLineNum, myCharNum, 
            "Undeclared identifier");
        }else{
            this.myStruct = mySym.getStruct();
        }
        // System.out.println(this.myStrVal + this.myStruct);
        
        return;
    }
    public Sym getSym(){
        return mySym;
    }
    public void setSym(Sym mySym){
        this.mySym = mySym;
    }
    public StructDeclNode getStruct(){
        return myStruct;
    }
    public void setStruct(StructDeclNode myStruct, Sym sym){
        this.myStruct = myStruct;
        sym.setStruct(myStruct);
        // System.out.println("setting " + myStrVal);
    }
    private int myLineNum;
    private int myCharNum;
    private String myStrVal;
    private Sym mySym;
    private StructDeclNode myStruct;
}

class DotAccessExpNode extends ExpNode {
    public DotAccessExpNode(ExpNode loc, IdNode id) {
        myLoc = loc;    
        myId = id;
    }

    public void unparse(PrintWriter p, int indent) {
        p.print("(");
        myLoc.unparse(p, 0);
        p.print(").");
        myId.unparse(p, 0);
    }
    public void nameAnalyze(SymTable symTable){
        myLoc.nameAnalyze(symTable);
        StructDeclNode lhs = this.getLHSStruct(symTable);
        if(lhs == null){
            return;
        }
        SymTable leftTable = lhs.getSymTable();
        // leftTable.print();
        Sym foundItem = leftTable.lookupGlobal(myId.toString());
        if(foundItem == null) {
            ErrMsg.fatal(((IdNode)myId).getLineNum(), 
            ((IdNode)myId).getCharNum(),  "Invalid struct field name");
        }else{
            myId.setSym(foundItem);
        }
            
    }

    private StructDeclNode getLHSStruct(SymTable symTable){
        // System.out.println(myId.toString());
        // symTable.print();
        if(myLoc instanceof IdNode){
            // get the sym for this id
            Sym lookUpSym = symTable.lookupGlobal(((IdNode)myLoc).toString());
            if(lookUpSym == null){
                /* ErrMsg.fatal(((IdNode)myLoc).getLineNum(), 
                ((IdNode)myLoc).getCharNum(), 
                "Undeclared identifier");
		*/
                return null;
            }
            if(lookUpSym.getStruct() == null){
                // System.out.println(lookUpSym.getType());
                ErrMsg.fatal(((IdNode)myLoc).getLineNum(), 
                ((IdNode)myLoc).getCharNum(), 
                "Dot-access of non-struct type");
                return null;
            }
            return ((IdNode)myLoc).getStruct();
        }else{
            // System.out.println("case02 " + myLoc.toString() + myId.toString());
            StructDeclNode lhs = ((DotAccessExpNode) myLoc).getLHSStruct(symTable);
            if(lhs == null){
                return null;
            }
            SymTable leftTable = lhs.getSymTable();
            // leftTable.print();
            // System.out.println(((DotAccessExpNode)myLoc).myId.toString());
            Sym foundItem = leftTable.lookupGlobal(((DotAccessExpNode)myLoc).myId.toString());
            if(foundItem==null){
                return null;
            }else{
                // System.out.println(foundItem.getStruct());
                return foundItem.getStruct();
            }
            // return myStruct;
        }
    }
    // 2 kids
    private ExpNode myLoc;    
    private IdNode myId;
}

class AssignNode extends ExpNode {
    public AssignNode(ExpNode lhs, ExpNode exp) {
        myLhs = lhs;
        myExp = exp;
    }

    public void unparse(PrintWriter p, int indent) {
        if (indent != -1)  p.print("(");
        myLhs.unparse(p, 0);
        p.print(" = ");
        myExp.unparse(p, 0);
        if (indent != -1)  p.print(")");
    }
    public void nameAnalyze(SymTable symTable){
        myLhs.nameAnalyze(symTable);
        myExp.nameAnalyze(symTable);
    }

    // 2 kids
    private ExpNode myLhs;
    private ExpNode myExp;
}

class CallExpNode extends ExpNode {
    public CallExpNode(IdNode name, ExpListNode elist) {
        myId = name;
        myExpList = elist;
    }

    public CallExpNode(IdNode name) {
        myId = name;
        myExpList = new ExpListNode(new LinkedList<ExpNode>());
    }

    // ** unparse **
    public void unparse(PrintWriter p, int indent) {
        myId.unparse(p, 0);
        p.print("(");
        if (myExpList != null) {
            myExpList.unparse(p, 0);
        }
        p.print(")");
    }
    public void nameAnalyze(SymTable symTable){
        myId.nameAnalyze(symTable);
        myExpList.nameAnalyze(symTable);
    }
    // 2 kids
    private IdNode myId;
    private ExpListNode myExpList;  // possibly null
}

abstract class UnaryExpNode extends ExpNode {
    public UnaryExpNode(ExpNode exp) {
        myExp = exp;
    }
    public void nameAnalyze(SymTable symTable){
        myExp.nameAnalyze(symTable);
    }
    // one child
    protected ExpNode myExp;
}

abstract class BinaryExpNode extends ExpNode {
    public BinaryExpNode(ExpNode exp1, ExpNode exp2) {
        myExp1 = exp1;
        myExp2 = exp2;
    }
    public void nameAnalyze(SymTable symTable){
        myExp1.nameAnalyze(symTable);
        myExp2.nameAnalyze(symTable);
    }
    // two kids
    protected ExpNode myExp1;
    protected ExpNode myExp2;
}

// **********************************************************************
// <<<Subclasses of UnaryExpNode>>>
// **********************************************************************

class UnaryMinusNode extends UnaryExpNode {
    public UnaryMinusNode(ExpNode exp) {
        super(exp);
    }

    public void unparse(PrintWriter p, int indent) {
        p.print("(-");
        myExp.unparse(p, 0);
        p.print(")");
    }
}

class NotNode extends UnaryExpNode {
    public NotNode(ExpNode exp) {
        super(exp);
    }

    public void unparse(PrintWriter p, int indent) {
        p.print("(!");
        myExp.unparse(p, 0);
        p.print(")");
    }
}

// **********************************************************************
// <<<Subclasses of BinaryExpNode>>>
// **********************************************************************

class PlusNode extends BinaryExpNode {
    public PlusNode(ExpNode exp1, ExpNode exp2) {
        super(exp1, exp2);
    }

    public void unparse(PrintWriter p, int indent) {
        p.print("(");
        myExp1.unparse(p, 0);
        p.print(" + ");
        myExp2.unparse(p, 0);
        p.print(")");
    }
}

class MinusNode extends BinaryExpNode {
    public MinusNode(ExpNode exp1, ExpNode exp2) {
        super(exp1, exp2);
    }

    public void unparse(PrintWriter p, int indent) {
        p.print("(");
        myExp1.unparse(p, 0);
        p.print(" - ");
        myExp2.unparse(p, 0);
        p.print(")");
    }
}

class TimesNode extends BinaryExpNode {
    public TimesNode(ExpNode exp1, ExpNode exp2) {
        super(exp1, exp2);
    }

    public void unparse(PrintWriter p, int indent) {
        p.print("(");
        myExp1.unparse(p, 0);
        p.print(" * ");
        myExp2.unparse(p, 0);
        p.print(")");
    }
}

class DivideNode extends BinaryExpNode {
    public DivideNode(ExpNode exp1, ExpNode exp2) {
        super(exp1, exp2);
    }

    public void unparse(PrintWriter p, int indent) {
        p.print("(");
        myExp1.unparse(p, 0);
        p.print(" / ");
        myExp2.unparse(p, 0);
        p.print(")");
    }
}

class AndNode extends BinaryExpNode {
    public AndNode(ExpNode exp1, ExpNode exp2) {
        super(exp1, exp2);
    }

    public void unparse(PrintWriter p, int indent) {
        p.print("(");
        myExp1.unparse(p, 0);
        p.print(" && ");
        myExp2.unparse(p, 0);
        p.print(")");
    }
}

class OrNode extends BinaryExpNode {
    public OrNode(ExpNode exp1, ExpNode exp2) {
        super(exp1, exp2);
    }

    public void unparse(PrintWriter p, int indent) {
        p.print("(");
        myExp1.unparse(p, 0);
        p.print(" || ");
        myExp2.unparse(p, 0);
        p.print(")");
    }
}

class EqualsNode extends BinaryExpNode {
    public EqualsNode(ExpNode exp1, ExpNode exp2) {
        super(exp1, exp2);
    }

    public void unparse(PrintWriter p, int indent) {
        p.print("(");
        myExp1.unparse(p, 0);
        p.print(" == ");
        myExp2.unparse(p, 0);
        p.print(")");
    }
}

class NotEqualsNode extends BinaryExpNode {
    public NotEqualsNode(ExpNode exp1, ExpNode exp2) {
        super(exp1, exp2);
    }

    public void unparse(PrintWriter p, int indent) {
        p.print("(");
        myExp1.unparse(p, 0);
        p.print(" != ");
        myExp2.unparse(p, 0);
        p.print(")");
    }
}

class LessNode extends BinaryExpNode {
    public LessNode(ExpNode exp1, ExpNode exp2) {
        super(exp1, exp2);
    }

    public void unparse(PrintWriter p, int indent) {
        p.print("(");
        myExp1.unparse(p, 0);
        p.print(" < ");
        myExp2.unparse(p, 0);
        p.print(")");
    }
}

class GreaterNode extends BinaryExpNode {
    public GreaterNode(ExpNode exp1, ExpNode exp2) {
        super(exp1, exp2);
    }

    public void unparse(PrintWriter p, int indent) {
        p.print("(");
        myExp1.unparse(p, 0);
        p.print(" > ");
        myExp2.unparse(p, 0);
        p.print(")");
    }
}

class LessEqNode extends BinaryExpNode {
    public LessEqNode(ExpNode exp1, ExpNode exp2) {
        super(exp1, exp2);
    }

    public void unparse(PrintWriter p, int indent) {
        p.print("(");
        myExp1.unparse(p, 0);
        p.print(" <= ");
        myExp2.unparse(p, 0);
        p.print(")");
    }
}

class GreaterEqNode extends BinaryExpNode {
    public GreaterEqNode(ExpNode exp1, ExpNode exp2) {
        super(exp1, exp2);
    }

    public void unparse(PrintWriter p, int indent) {
        p.print("(");
        myExp1.unparse(p, 0);
        p.print(" >= ");
        myExp2.unparse(p, 0);
        p.print(")");
    }
}
