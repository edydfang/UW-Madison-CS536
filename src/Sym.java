public class Sym {
    /*
    Class to represent symbols in the code.
     */

    // the type this symbol belongs to, can be identifier, assign, int-lit, etc.
    private String type;

    public Sym(String type) {
        /*
        Construction method
         */
        this.type = type;
    }

    public String getType() {
        /*
        get the type of the symbol
         */
        return this.type;
    }

    @Override
    public String toString() {
        /*
        override the toString() method
         */
        return this.type;
    }
}
