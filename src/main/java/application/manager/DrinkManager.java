package application.manager;

import application.model.AnswerRequest;
import application.model.Response;

/**
 * Created by wgrabis on 12.11.2017.
 */
public interface DrinkManager {

    void initialize();
    void answerQuestion(AnswerRequest answer);
    Response consult();
}
