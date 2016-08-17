package library;

import org.junit.Test;
import static org.junit.Assert.*;

public class LibraryTest {

    @Test 
    public void testSomeLibraryMethod() {
        Library lib = new Library();
        assertTrue("someLibraryMethod should return 'true'", lib.someLibraryMethod());
    }
}
