package application.manager.impl;

import application.manager.DrinkManager;
import org.jpl7.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import sun.reflect.generics.reflectiveObjects.NotImplementedException;

import java.net.URL;
import java.net.URLClassLoader;
import java.util.Map;

/**
 * Created by wgrabis on 12.11.2017.
 */

@Service
public class DrinkManagerImpl implements DrinkManager{

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    public DrinkManagerImpl(){
        JPL.init();

        //initialize prolog rules file
        String prologFilePath = getClass().getResource("/prolog/drink.pl").getPath();
        Term loadPrologFile = new Compound("consult", new Term[]{new Atom(prologFilePath)});
        Query loadQuery = new Query(loadPrologFile);
        loadQuery.open();

        logger.info("Initializing prolog with rule file:" + loadQuery.getSolution());
    }

    public void initialize() {
        Query initializeQuery = new Query(new Compound("initialize"));
        initializeQuery.open();
    }

    public String answerQuestion(String question, String answer) {
        throw new NotImplementedException();
    }

    public String consult() {
        Query consultQuery = new Query(new Compound("askDrink", new Term[]{new Variable("Answer")}));
        consultQuery.open();

        String answer = consultQuery.getSolution().get("Answer").toString();
        logger.debug(answer);

        return answer;
    }
}

