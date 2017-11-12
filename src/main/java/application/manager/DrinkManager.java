package application.manager;

/**
 * Created by wgrabis on 12.11.2017.
 */
public interface DrinkManager {

    void initialize();
    String answerQuestion(String question, String answer);
    String consult();
}
