package application.model;

/**
 * Created by wg on 11/19/17.
 */
public class AnswerRequest {
    private String question;
    private boolean answer;

    public AnswerRequest(){

    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public boolean isAnswer() {
        return answer;
    }

    public void setAnswer(boolean answer) {
        this.answer = answer;
    }
}
