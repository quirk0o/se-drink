package application.controller;

import application.manager.DrinkManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by wgrabis on 12.11.2017.
 */

@RestController
public class DrinkController {

    @Autowired
    DrinkManager drinkManager;

    @RequestMapping(value = "/drink/init", method = RequestMethod.GET)
    public void InitConsultEngine(){
        drinkManager.initialize();
    }

    @RequestMapping(value = "/drink/consult", method = RequestMethod.GET)
    public String Consult(){
        return drinkManager.consult();
    }

    @RequestMapping(value = "/drink/answer", method = RequestMethod.GET)
    public void GetDrink(@PathVariable String question, @PathVariable  String answer){
        drinkManager.answerQuestion(question, answer);
    }
}
