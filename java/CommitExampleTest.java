import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.Test;
import CommitExample

public class CommitExampleTest {

    @Test
    public void testCorrect() {
        assertEquals(6, CommitExample.multiply(2, 3));
    }

    @Test
    public void testWrong() {
        // This test will also pass since the logic is correct, 
        // but it could be modified if the original intent was to make a failing test.
        assertEquals(6, CommitExample.multiply(2, 3));
    }
}
