:- dynamic
    xpositive/2,
    xnegative/2.

drink(ice_coffee) :-
    drink(coffee),
    weather(warm).

drink(americano) :-
    drink(coffee),
    weather(cold).

drink(coffee) :- daytime(morning),
				tiredness(high).

drink(tea) :- daytime(morning),
				\+tiredness(high).

drink(beer) :-
    daytime(evening),
    weekend().

drink(juice) :- \+daytime(morning), \+daytime(evening).

tiredness(high) :- positive(tiredness,high).

weekend() :- day_of_week(friday); day_of_week(saturday); day_of_week(sunday).

day_of_week(X) :- positive(day_of_week, X).

daytime(morning) :- positive(it, morning).

daytime(evening) :- positive(it, evening).

weather(warm) :- positive(weather, warm).

weather(cold) :- \+weather(warm).

positive(X,Y) :- xpositive(X,Y), !.

positive(X,Y) :- \+xnegative(X,Y), ask(X,Y).

negative(X,Y) :- xnegative(X,Y), !.

negative(X,Y) :- \+xpositive(X,Y), ask(X,Y).

ask(X,Y) :- !, format('~w is ~w ? (y/n)~n',[X,Y]),
                    read(Reply),
                    (Reply = 'n') ->
                    	remember(X,Y,no),
				false;
			    	(Reply = 'y') ->			    	
			    		remember(X,Y,yes),
					true.
                    
remember(X, Y) :- assertz(xequals(X, Y)).

remember(X,Y,yes) :- assertz(xpositive(X,Y)).

remember(X,Y,no) :- assertz(xnegative(X,Y)).

clear_memory:- write('Click something to quit...'), nl,
                    retractall(xpositive(_,_)),
                    retractall(xnegative(_,_)),
                    get_char(_).
                    
start :- drink(X), !,
            format('~nYour drink is: ~w', X),
            nl, clear_memory.
            
start :- write('I have no idea what you should drink. Sorry...'), nl.
