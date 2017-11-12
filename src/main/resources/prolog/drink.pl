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


drink(coffee) :- time_of_day(morning),
				tiredness(high).

drink(tea) :- time_of_day(morning),
				\+tiredness(high).


drink(beer) :-
    drink(alcohol),
    like(fizzy),
    like(bitter).

drink(wine) :- drink(alcohol).

drink(alcohol) :- \+weekend().

drink(alcohol) :- time_of_day(evening); time_of_day(night).

drink(camomile) :- time_of_day(afternoon).

drink(camomile) :-
	\+time_of_day(morning),
	stress(high),
	company(none),
	no_alergy(camomile).

drink(mint) :- 		
	stomach_ache(true),
	like(hot).

drink(cola) :- 		
	stomach_ache(true),
	like(cold).

drink(juice).

tiredness(high) :- positive(tiredness,high).

weekend() :- day_of_week(X), member(X, [friday, saturday, sunday]).

weather(warm) :- season(summer).

weather(warm) :- positive(weather, warm).

weather(cold) :- season(winter).

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

like(hot) :- xpositive(like, hot); ask_like(hot).

like(cold) :- xpositive(like, cold);ask_like(cold).

like(fizzy) :- xpositive(like, fizzy); ask_like(fizzy).

like(sour) :- xpositive(like, sour); ask_like(sour).

like(bitter) :- xpositive(like, bitter); ask_like(bitter).


:- dynamic xtimestamp/1,
    xdatetime/1,
    xdate/1,
    xtime/1,
    xday_of_week/1,
    xmonth/1,
    xhour/1,
    xseason/1,
    xtime_of_day/1.

timestamp(T) :- xtimestamp(T), !.
timestamp(T) :- get_time(T),
    assertz(xtimestamp(T)).

datetime(D) :- xdatetime(D), !.
datetime(D) :- timestamp(T),
    stamp_date_time(T, D, local),
    assertz(xdatetime(D)).

day(D) :- xdate(D), !.
day(D) :- datetime(DT),
    date_time_value(year, DT, Year),
    date_time_value(month, DT, Month),
    date_time_value(day, DT, Day),
    D = date(Year, Month, Day),
    assertz(xdate(D)).

between(range(A, B), X) :- X >= A, X < B.

hour(H) :- xhour(H), !.
hour(H) :- datetime(DT),
    date_time_value(hour, DT, H).

month(M) :- xmonth(M), !.
month(M) :- datetime(D),
    date_time_value(month, D, M).

season(S) :- xseason(S), !.
season(S) :- month(M),
    between(range(6, 9), M),
    S = summer,
    assertz(xseason(S)), !.
season(S) :- month(M),
    between(range(9, 12), M),
    S = fall,
    assertz(xseason(S)), !.
season(S) :- month(M),
    M =:= 12,
    S = winter,
    assertz(xseason(S)), !.
season(S) :- month(M),
    between(range(1, 4), M),
    S = winter,
    assertz(xseason(S)), !.
season(S) :- month(M),
    between(range(4, 6), M),
    S = spring,
    assertz(xseason(S)).

day_of_week_name(1, monday).
day_of_week_name(2, tuesday).
day_of_week_name(3, wednesday).
day_of_week_name(4, thursday).
day_of_week_name(5, friday).
day_of_week_name(6, saturday).
day_of_week_name(7, sunday).

day_of_week(DoW) :- xday_of_week(DoW), !.
day_of_week(DoW) :- day(D),
    day_of_the_week(D, DoWNum),
    day_of_week_name(DoWNum, DoW),
    assertz(xday_of_week(DoW)).

time_of_day(T) :- xtime_of_day(T), !.
time_of_day(T) :- hour(H),
    between(range(4, 12), H),
    T = morning,
    assertz(xtime_of_day(T)), !.
time_of_day(T) :- hour(H),
    between(range(12, 18), H),
    T = afternoon,
    assertz(xtime_of_day(T)), !.
time_of_day(T) :- hour(H),
    between(range(18, 22), H),
    T = evening,
    assertz(xtime_of_day(T)), !.
time_of_day(T) :- hour(H),
    between(range(22, 24), H),
    T = night,
    assertz(xtime_of_day(T)), !.
time_of_day(T) :- hour(H),
    between(range(0, 4), H),
    T = night,
    assertz(xtime_of_day(T)).

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

ask_like(X) :- !, format('Do you like ~w drink? (y/n)~n',[X]),
                    read(Reply),
                    (Reply = 'n') ->
                    	remember(like, X, no),
				false;
			    	(Reply = 'y') ->			    	
			    		remember(like, X, yes),
					true.

remember(X,Y,yes) :- assertz(xpositive(X,Y)).

remember(X,Y,no) :- assertz(xnegative(X,Y)).

clear_memory:- write('Click something to quit...'), nl,
                    retractall(xpositive(_,_)),
                    retractall(xnegative(_,_)),
                    get_char(_).
                    
start :- drink(X), !,
            format('~nYour drink is: ~w', X),
            nl, clear_memory.
            
start :- write('I have no idea what you should drink. Sorry...'), nl, clear_memory.


#enable for multiple users
initialize() :-
    true.

Question(coffee, like).


evalPositive(X, Answer) :-
    xpositive(X),
    !.

evalPositive(X, Answer) :-
    \+xpositive(X),
    Answer = Question(X, like).

evalDrink(coffee, Answer) :-
    evalPositive(coffee, Answer).

askDrink(Answer) :-
    evalDrink(X, Answer).

answer(Question, true) :-
    true.

answer(Question, false) :-
    true.
