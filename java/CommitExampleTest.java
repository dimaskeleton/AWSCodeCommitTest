import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.Test;

public class CommitExampleTest {

    @Test
    public void testCorrect() {
        assertEquals(6, CommitExample.multiply(2, 3));
    }

    @Test
    public void testWrong() {
        assertEquals(6, CommitExample.multiply(2, 3));
    }
}
