package application.controller;

import application.manager.DrinkManager;
import application.model.AnswerRequest;
import application.model.DrinkResponse;
import application.model.Response;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * Created by wgrabis on 12.11.2017.
 */

@RestController
public class DrinkController {

    @Autowired
    DrinkManager drinkManager;

    @RequestMapping(value = "/api/drink/clear", method = RequestMethod.GET)
    public void InitConsultEngine(){
        drinkManager.initialize();
    }

    @RequestMapping(value = "/api/drink/consult", method = RequestMethod.GET)
    public Response Consult(){
        return drinkManager.consult();
    }

    @RequestMapping(value = "/api/drink/answer", method = RequestMethod.POST)
    public String GetDrink(@RequestBody AnswerRequest answer){
        drinkManager.answerQuestion(answer);

        return "Ok";
    }
}
