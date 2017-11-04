:- dynamic
    xpositive/2,
    xngative/2.

drink(cofee) :- daytime(morning),
				tiredness(high).

drink(tea) :- daytime(morning),
				\+tiredness(high).

drink(juice) :- \+daytime(morning).

tiredness(high) :- positive(tiredness,high).

daytime(morning):- positive(it,morning).			 

positive(X,Y) :- xpositive(X,Y), !.

positive(X,Y) :- \+xngative(X,Y), ask(X,Y).

ngative(X,Y) :- xngative(X,Y), !.

ngative(X,Y) :- \+xpositive(X,Y), ask(X,Y).

ask(X,Y) :- !, format('~w is ~w ? (y/n)~n',[X,Y]),
                    read(Reply),
                    (Reply = 'n') ->
                    	remember(X,Y,no),
				false;
			    	(Reply = 'y') ->			    	
			    		remember(X,Y,yes),
					true.
                    
remember(X,Y,yes) :- assertz(xpositive(X,Y)).

remember(X,Y,no) :- assertz(xngative(X,Y)).

clear_memory:- write('Click something to quit...'), nl,
                    retractall(xpositive(_,_)),
                    retractall(xngative(_,_)),
                    get_char(_).
                    
start :- drink(X), !,
            format('~nYour drink is: ~w', X),
            nl, clear_memory.
            
start :- write('I have no idea what you should drink. Sorry...'), nl.
            