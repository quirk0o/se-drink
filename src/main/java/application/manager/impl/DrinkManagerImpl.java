package application.manager.impl;

import application.manager.DrinkManager;
import org.jpl7.JPL;
import org.springframework.stereotype.Service;

import java.net.URL;
import java.net.URLClassLoader;
import java.util.Map;

/**
 * Created by wgrabis on 12.11.2017.
 */

@Service
public class DrinkManagerImpl implements DrinkManager{
    public DrinkManagerImpl(){

        JPL.init();
    }
}

