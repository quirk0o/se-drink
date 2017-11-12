package application.manager.impl;

import application.manager.DrinkManager;
import org.jpl7.*;
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

        Term load = new Compound("consult", new Term[]{new Atom("/home/wg/Documents/se-drink/prolog/test.pl")});
        Query x = new Query(load);
        x.open();
        System.out.println(x.getSolution());

        Term goal = new Compound( "teacher_of", new Term[]{new Atom("aristotle")});
        Query q = new Query( goal );

        q.open();

        System.out.println(q.getSolution());

        Term goal2 = new Compound( "teacher_of", new Term[]{new Atom("xsaristotle")});
        Query q2 = new Query( goal2 );

        q2.open();

        System.out.println(q2.getSolution());
    }
}

