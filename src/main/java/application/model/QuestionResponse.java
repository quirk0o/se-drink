package application.model;

import java.util.List;

/**
 * Created by wg on 11/19/17.
 */
public class QuestionResponse extends Response {
    private List<String> question;
    private static String questionType = "question";

    public QuestionResponse(List<String> question){
        super(questionType);
        this.question = question;
    }

    public List<String> getQuestion() {
        return question;
    }

    public void setQuestion(List<String> question) {
        this.question = question;
    }
}
