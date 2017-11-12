package application.controller;

import application.manager.DrinkManager;
import org.springframework.beans.factory.annotation.Autowired;
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

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public void GetDrink(){

    }
}
