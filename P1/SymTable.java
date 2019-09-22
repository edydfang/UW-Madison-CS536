import java.util.*;

public class SymTable {
    /*
     * A Symbol Table used to store all the symbols appears in the source code.
     */

    // List of HashMap to store symbols in different scopes
    private List<HashMap<String, Sym>> symTable;

    public SymTable() {
        /*
         * Construction method
         */
        this.symTable = new LinkedList<HashMap<String, Sym>>();
        this.symTable.add(0, new HashMap<>());
    }

    void addDecl(String name, Sym sym) throws EmptySymTableException, DuplicateSymException {
        /*
         * Add the Declaration to the fist scope in the linked list
         */
        if (symTable.isEmpty()) {
            throw new EmptySymTableException();
        }
        if (name == null || sym == null) {
            throw new NullPointerException();
        }
        if (this.symTable.get(0).containsKey(name)) {
            throw new DuplicateSymException();
        }
        this.symTable.get(0).put(name, sym);

    }

    void addScope() {
        /*
         * Add the scope hash map to the front of the linked list
         */
        this.symTable.add(0, new HashMap<>());
    }

    Sym lookupLocal(String name) throws EmptySymTableException {
        /*
         * Look up the symbol in the first HashMap
         */
        if (this.symTable.isEmpty()) {
            throw new EmptySymTableException();
        }
        return this.symTable.get(0).getOrDefault(name, null);
    }

    Sym lookupGlobal(String name) throws EmptySymTableException {
        /*
         * Look up the symbol in the whole Symbol Table
         */
        if (this.symTable.isEmpty()) {
            throw new EmptySymTableException();
        }
        for (HashMap<String, Sym> map : symTable) {
            if (map.containsKey(name)) {
                return map.get(name);
            }
        }
        return null;
    }

    void removeScope() throws EmptySymTableException {
        /*
         * Remove the Scope HashMap from the front of the linked list
         */
        if (this.symTable.isEmpty()) {
            throw new EmptySymTableException();
        }
        this.symTable.remove(0);
    }

    void print() {
        /*
         * Print the content of the Symbol Table
         */
        StringBuilder outputStr = new StringBuilder();
        outputStr.append("\nSym Table\n");
        for (HashMap<String, Sym> map : symTable) {
            outputStr.append(map.toString());
            outputStr.append("\n");
        }
        outputStr.append("\n");
        System.out.print(outputStr.toString());
    }

}
