package application.model.response;

import application.model.DrinkResponse;
import application.model.QuestionResponse;
import application.model.Response;
import org.jpl7.Term;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

/**
 * Created by wg on 11/19/17.
 */
public class ResponseFactory {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    public Response buildResponse(Term term){
        logger.info(term.name());

        if(term.name().equals("question")){
            List<String> subTerms = new LinkedList<>();

            Term questionList = term.args()[0];
            for(Term subNames : questionList.toTermArray()){
                subTerms.add(subNames.name());
            }

            subTerms.add(term.args()[1].name());
            return new QuestionResponse(subTerms);
        } else if(term.name().equals("suggestedDrink")) {
            return new DrinkResponse(term.args()[0].name());
        }
        return null;
    }
}
