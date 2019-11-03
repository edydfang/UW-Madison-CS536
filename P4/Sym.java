import java.util.LinkedList;

public class Sym {
    private String type;
    // private String kind;
    private SymTable symTable;
    private StructDeclNode struct;
    
    public Sym(String type) {
        this.type = type;
    }
    public void setStruct(StructDeclNode struct){
        this.struct = struct;
    }
    public StructDeclNode getStruct(){
        return this.struct;
    }
    public void setSymTable(SymTable symTable) {
        this.symTable = symTable;
    }
    public SymTable getSymTable(SymTable symTable) {
        return this.symTable;
    }
    public String getType() {
        return type;
    }
    
    public String toString() {
        return type;
    }
}

class FuncSym extends Sym {
    private LinkedList<String> paramTypes;
    private String returnType;
    public FuncSym(String returnType, LinkedList<String> paramTypes) {
        super("function");
        this.paramTypes = paramTypes;
        this.returnType = returnType;
        // System.out.println("adding" + String.join(", ", paramTypes));
    }

    public int getParamNum(){
        return paramTypes.size();
    }
    public String toString() {
        String params = String.join(", ", paramTypes);
        if (params.equals("")) {
            params = "void";
        }
        return params + " -> " + returnType;
    }
}
