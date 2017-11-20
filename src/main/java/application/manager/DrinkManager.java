package application.manager;

import application.model.Response;

/**
 * Created by wgrabis on 12.11.2017.
 */
public interface DrinkManager {

    void initialize();
    void answerQuestion(String question, String answer);
    Response consult();
}
