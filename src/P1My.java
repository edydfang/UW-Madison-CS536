public class P1My {
    /*
    Test code for Class Sym, SymTable, DuplicateSymException and EmptySymTableException
     */
    public static void main(String[] args) {
        /*
        Main function of testing code
         */
        // An indicator to check whether the right exceptions are thrown.
        int exceptionIndicator = 0;
        // test cases for Sym
        Sym symInt = new Sym("int-lit");
        String testSymType = symInt.getType();
        if (!testSymType.equals("int-lit"))
            System.out.println("Sym getType() Wrong");

        // test cases for SymTable
        SymTable testSymTable = new SymTable();

        try {
            // first remove the initial scope
            testSymTable.removeScope();
        } catch (EmptySymTableException ex) {
            System.out.println("Unexpected Exception.");
        }

        // EmptySymTableException from lookupLocal
        try {

            testSymTable.lookupLocal("varA");
        } catch (EmptySymTableException ex) {
            exceptionIndicator = 1;
        }
        if (exceptionIndicator != 1) {
            System.out.println("Exception thrown on attempt to lookupLocal with empty SymTable failed.");
        }
        exceptionIndicator = 0;
        // EmptySymTableException from lookupGlobal
        try {
            testSymTable.lookupGlobal("varA");
        } catch (EmptySymTableException ex) {
            exceptionIndicator = 1;
        }
        if (exceptionIndicator != 1) {
            System.out.println("Exception thrown on attempt to lookupGlobal with empty SymTable failed.");
        }
        exceptionIndicator = 0;

        // EmptySymTableException from removeScope
        try {
            testSymTable.removeScope();
        } catch (EmptySymTableException ex) {
            exceptionIndicator = 1;
        }
        if (exceptionIndicator != 1) {
            System.out.println("EmptySymTableException thrown on attempt to removeScope with empty SymTable failed.");
        }
        exceptionIndicator = 0;

        // EmptySymTableException from addDecl
        try {
            testSymTable.addDecl("symName", symInt);
        } catch (EmptySymTableException | DuplicateSymException ex) {
            if (ex instanceof EmptySymTableException) {
                exceptionIndicator = 1;
            }
        }
        if (exceptionIndicator != 1) {
            System.out.println("EmptySymTableException thrown on attempt to addDecl with empty SymTable failed.");
        }
        exceptionIndicator = 0;

        // add Scope
        testSymTable.addScope();
        // add Declaration
        try {
            testSymTable.addDecl("symInt1", symInt);
        } catch (EmptySymTableException | DuplicateSymException ex) {
            System.out.println("Test Failed on addDecl after adding scope");
        }

        // add Declaration duplication
        try {
            testSymTable.addDecl("symInt1", symInt);
        } catch (EmptySymTableException | DuplicateSymException ex) {
            if (ex instanceof DuplicateSymException) {
                exceptionIndicator = 1;
            }
        }
        if (exceptionIndicator != 1) {
            System.out.println("Test DuplicateSymException failed.");
        }
        exceptionIndicator = 0;

        // Tests for addDecl, removeScope and lookup
        Sym symAssign = new Sym("assign");
        Sym symSemiColon = new Sym("semi-colon");
        Sym symIdent = new Sym("ident");
        try {
            testSymTable.print();
            testSymTable.addDecl("assign1", symAssign);
            testSymTable.addScope();
            testSymTable.addDecl("semi-colon1", symSemiColon);
            testSymTable.addDecl("ident1", symIdent);
            testSymTable.print();
            Sym lookedupLocalSym1 = testSymTable.lookupLocal("ident1");
            Sym lookedupLocalSym2 = testSymTable.lookupLocal("assign1");
            if (lookedupLocalSym1 == null || lookedupLocalSym1 != symIdent) {
                System.out.println("lookupLocal existed sym failed.");
            }
            if (lookedupLocalSym2 != null) {
                System.out.println("lookupLocal null sym failed.");
            }
            Sym lookedupGlobalSym1 = testSymTable.lookupGlobal("assign1");
            Sym lookedupGlobalSym2 = testSymTable.lookupGlobal("assign2");
            if (lookedupGlobalSym1 == null || lookedupGlobalSym1 != symAssign) {
                System.out.println("lookupGlobal existed sym failed.");
            }
            if (lookedupGlobalSym2 != null) {
                System.out.println("lookupGlobal null sym failed.");
            }
            testSymTable.removeScope();
            testSymTable.print();
            testSymTable.removeScope();
            testSymTable.print();
        } catch (EmptySymTableException | DuplicateSymException ex) {
            System.out.println("Test Failed on addDecl after adding scope");
        }


    }
}
