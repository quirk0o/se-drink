:- dynamic
    	xpositive/2,
    	xnegative/2,
    	xpositive/1.

drink(ice_coffee, Answer) :-
    	drink(coffee, Answer),
    	weather(warm, Answer),
	no_alergy(lactose, Answer).

drink(americano, Answer) :-
    	drink(coffee, Answer),
    	weather(cold, Answer),
	alergy(lactose, Answer).

drink(white_cofee, Answer) :-
    	drink(coffee, Answer),
    	weather(cold, Answer),
	no_alergy(lactose, Answer).


drink(coffee, Answer) :- time_of_day(morning, Answer),
				tiredness(high, Answer).

drink(ice_tea_peach, Answer) :-
        drink(ice_tea, Answer),
        like(peach, Answer).

drink(ice_tea_green, Answer) :-
        drink(ice_tea, Answer),
        like(green, Answer).

drink(ice_tea_lemon, Answer) :-
        drink(ice_tea, Answer),
        like(lemon, Answer).

drink(ice_tea, Answer) :-
        drink(tea, Answer),
        weather(warm, Answer),
        tiredness(high, Answer).

drink(fruit_tea, Answer) :-
        drink(tea, Answer),
        weather(cold, Answer),
        \+like(dark_tea, Answer),
        stomach_ache(false, Answer).

drink(green_tea, Answer) :-
        drink(tea, Answer),
        weather(cold, Answer),
        \+like(dark_tea, Answer),
        stomach_ache(true, Answer).

drink(earl_grey_tea, Answer) :-
        drink(dark_tea, Answer),
        like(british_style, Answer).

drink(tea_with_lemon, Answer) :-
        drink(dark_tea, Answer),
        like(lemon, Answer).

drink(dark_tea, Answer) :-
        drink(tea, Answer),
        weather(cold, Answer),
        like(dark_tea, Answer).

drink(tea, Answer) :- time_of_day(morning, Answer),
				\+tiredness(high, Answer).

drink(beer, Answer) :-
    drink(alcohol, Answer),
    like(fizzy, Answer),
    like(bitter, Answer).

drink(wine, Answer) :- drink(alcohol, Answer).

drink(alcohol, Answer) :- \+weekend().

drink(alcohol, Answer) :- time_of_day(evening); time_of_day(night).

drink(camomile, Answer) :- time_of_day(afternoon).

drink(camomile, Answer) :-
	\+time_of_day(morning),
	stress(high, Answer),
	company(none, Answer),
	no_alergy(camomile, Answer).

drink(mint, Answer) :-
	stomach_ache(true, Answer),
	like(hot).

drink(cola, Answer) :-
	stomach_ache(true, Answer),
	like(cold, Answer).

drink(orange_juice, Answer) :-
    drink(juice, Answer),
    like(orange, Answer).

drink(apple_juice, Answer) :-
    drink(juice, Answer),
    like(apple, Answer).

drink(lemonade, Answer) :-
    drink(juice, Answer),
    like(lemon, Answer).

drink(juice, Answer).

drink(water, Answer).

tiredness(high, Answer) :- positive(tiredness,high).

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
