package application.manager.impl;

import application.manager.DrinkManager;
import application.model.AnswerRequest;
import application.model.Response;
import application.model.response.ResponseFactory;
import org.jpl7.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import sun.reflect.generics.reflectiveObjects.NotImplementedException;

import java.net.URL;
import java.net.URLClassLoader;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * Created by wgrabis on 12.11.2017.
 */

@Service
public class DrinkManagerImpl implements DrinkManager{

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    private ResponseFactory responseFactory;

    public DrinkManagerImpl(){
        JPL.init();
        responseFactory = new ResponseFactory();

        //initialize prolog rules file
        String prologFilePath = getClass().getResource("/prolog/drink_v2.pl").getPath();
        Term loadPrologFile = new Compound("consult", new Term[]{new Atom(prologFilePath)});
        Query loadQuery = new Query(loadPrologFile);
        loadQuery.open();

        logger.info("Initializing prolog with rule file:" + loadQuery.getSolution());
    }

    public void initialize() {
        logger.info("Initialize");

        Query initializeQuery = new Query("clearAllRules");

        logger.info("Rules cleared:" + Boolean.toString(initializeQuery.hasSolution()));
    }

    public void answerQuestion(AnswerRequest answer) {
        logger.info("Answer: " + Boolean.toString(answer.isAnswer()));
        List<Term> termList = new LinkedList<>();
        for(int i = 0; i < answer.getQuestion().size() - 1; i++){
            termList.add(new Atom(answer.getQuestion().get(i)));
        }

        Term question = new Compound("answer", new Term[]{new Compound("question",
                new Term[]{
                        Util.termArrayToList(termList.toArray(new Term[0])),
                        new Atom(answer.getQuestion().get(answer.getQuestion().size() - 1))
        }), new Atom(Boolean.toString(answer.isAnswer()))});

        Query query = new Query(question);

        logger.info("Question answered: " + Boolean.toString(query.hasSolution()));
    }

    public Response consult() {
        Query consultQuery = new Query(new Compound("consultDrink", new Term[]{new Variable("Answer")}));
        consultQuery.open();

        Term answer = consultQuery.getSolution().get("Answer");
        logger.info("Consult");

        return responseFactory.buildResponse(answer);
    }
}

