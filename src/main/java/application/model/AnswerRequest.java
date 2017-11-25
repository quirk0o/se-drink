package application.model;

import java.util.List;

/**
 * Created by wg on 11/19/17.
 */
public class AnswerRequest {
    private List<String> question;
    private boolean answer;

    public AnswerRequest(){

    }

    public List<String> getQuestion() {
        return question;
    }

    public void setQuestion(List<String> question) {
        this.question = question;
    }

    public boolean isAnswer() {
        return answer;
    }

    public void setAnswer(boolean answer) {
        this.answer = answer;
    }
}
