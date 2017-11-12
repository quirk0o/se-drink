:- dynamic
    	xpositive/2,
    	xnegative/2.

drink(ice_coffee) :-
    	drink(coffee),
    	weather(warm),
	no_alergy(lactose).

drink(americano) :-
    	drink(coffee),
    	weather(cold),
	alergy(lactose).

drink(white_cofee) :-
    	drink(coffee),
    	weather(cold),
	no_alergy(lactose).


drink(coffee) :- daytime(morning),
				tiredness(high).

drink(tea) :- daytime(morning),
				\+tiredness(high).

drink(beer) :-
    daytime(evening),
    weekend().

drink(camomile) :- 
	(daytime(afternoon);
	daytime(evening)),
	stress(high),
	company(none),
	no_alergy(camomile).

drink(mint) :- 		
	stomach_ache(true),
	like(hot).

drink(cola) :- 		
	stomach_ache(true),
	like(cold).

drink(juice) :- \+daytime(morning), \+daytime(evening).


tiredness(high) :- positive(tiredness,high).

weekend() :- day_of_week(friday); day_of_week(saturday); day_of_week(sunday).

day_of_week(X) :- positive(day_of_week, X).

daytime(morning) :- positive(it, morning).

daytime(evening) :- positive(it, evening).

daytime(afternoon) :- positive(it, afternoon).

weather(warm) :- positive(weather, warm).

weather(cold) :- negative(weather, warm).

stress(high) :- positive(stress, high).

stress(low) :- negative(stress, high).

company(none) :- positive(company, none).

company(few) :- positive(company, few).

company(one) :- positive(company, one).

stomach_ache(true) :- positive(stomach_ache, sensible).

stomach_ache(false) :- negative(stomach_ache, sensible).

alergy(camomile) :- positive(alergy, camomile).

alergy(lactose) :- positive(alergy, lactose).

no_alergy(camomile) :- negative(alergy, camomile).

no_alergy(lactose) :- negative(alergy, lactose).

like(hot) :- xpositive(hot,1); askLike(hot).

like(cold) :- xpositive(cold,1);askLike(cold).


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

askLike(X) :- !, format('Do you like ~w drink? (y/n)~n',[X]),
                    read(Reply),
                    (Reply = 'n') ->
                    	remember(X,1,no),
				false;
			    	(Reply = 'y') ->			    	
			    		remember(X,1,yes),
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
