:- dynamic
    	xnegative/1,
    	xpositive/1,
    	question/2,
    	suggestedDrink/1,
    	parameterless/1,
    	subeval/1.

baseEvalDrink(Drink, [], Answer) :-
    Answer = suggestedDrink(Drink).

baseEvalDrink(Drink, [parameterless(Head) | Tail], Answer) :-
    Head,
    baseEvalDrink(Drink, Tail, Answer).

baseEvalDrink(Drink, [subeval(Head) | Tail], Answer) :-
    evalDrink(Head, NewAnswer),
    (NewAnswer == suggestedDrink(Head)
        ->  baseEvalDrink(Drink, Tail, Answer)
        ;   Answer = NewAnswer
    ).

baseEvalDrink(Drink, [regeval(Head) | Tail], Answer) :-
    call(Head, Answer, ReturnFlag),
    (ReturnFlag == true
        ->  true
        ;   baseEvalDrink(Drink, Tail, Answer)
    ).

/*
    Rules for drinks
*/

evalDrink(ice_coffee, Answer) :-
    baseEvalDrink(ice_coffee, [
        subeval(coffee),
        regeval(weather(warm)),
        regeval(no_alergy(lactose))
    ], Answer).

evalDrink(americano, Answer) :-
    baseEvalDrink(americano, [
        subeval(coffee),
        regeval(weather(cold)),
        regeval(alergy(lactose))
    ], Answer).

evalDrink(white_coffee, Answer) :-
    baseEvalDrink(white_coffee, [
        subeval(coffee),
        regeval(weather(cold)),
        regeval(no_alergy(lactose))
    ], Answer).

evalDrink(coffee, Answer) :-
    baseEvalDrink(coffee, [
        parameterless(time_of_day(morning)),
        regeval(tiredness(high))
    ], Answer).

evalDrink(ice_tea_peach, Answer) :-
    baseEvalDrink(ice_tea_peach, [
        subeval(ice_tea),
        regeval(like(peach))
    ], Answer).

evalDrink(ice_tea_green, Answer) :-
    baseEvalDrink(ice_tea_green, [
        subeval(ice_tea),
        regeval(like(green))
    ], Answer).

evalDrink(ice_tea_lemon, Answer) :-
    baseEvalDrink(ice_tea_lemon, [
        subeval(ice_tea),
        regeval(like(lemon))
    ], Answer).

evalDrink(ice_tea, Answer) :-
    baseEvalDrink(ice_tea, [
        subeval(tea),
        regeval(weather(warm)),
        regeval(tiredness(high))
    ], Answer).

evalDrink(fruit_tea, Answer) :-
    baseEvalDrink(fruit_tea, [
        subeval(tea),
        regeval(weather(cold)),
        regeval(\+like(dark_tea)),
        regeval(stomach_ache(false))
    ], Answer).

evalDrink(green_tea, Answer) :-
    baseEvalDrink(green_tea, [
        subeval(tea),
        regeval(weather(cold)),
        regeval(\+like(dark_tea)),
        regeval(stomach_ache(true))
    ], Answer).

evalDrink(earl_grey_tea, Answer) :-
    baseEvalDrink(earl_grey_tea, [
        subeval(dark_tea),
        regeval(like(british_style))
    ], Answer).

evalDrink(tea_with_lemon, Answer) :-
    baseEvalDrink(tea_with_lemon, [
        subeval(dark_tea),
        regeval(like(lemon))
    ], Answer).

evalDrink(dark_tea, Answer) :-
    baseEvalDrink(dark_tea, [
        subeval(tea),
        regeval(weather(cold)),
        regeval(like(dark_tea))
    ], Answer).

evalDrink(tea, Answer) :-
    baseEvalDrink(tea, [
        parameterless(time_of_day(morning)),
        regeval(tiredness(high))
    ], Answer).


evalDrink(beer, Answer) :-
    baseEvalDrink(beer, [
        subeval(alkohol),
        regeval(like(fizzy)),
        regeval(like(bitter))
    ], Answer).

evalDrink(wine, Answer) :-
    baseEvalDrink(wine, [
        subeval(alkohol)
    ], Answer).

evalDrink(alkohol, Answer) :-
    baseEvalDrink(alkohol, [
        parameterless((\+weekend()))
    ], Answer).

evalDrink(alkohol, Answer) :-
    baseEvalDrink(alkohol, [
        parameterless(time_of_day(evening));
        parameterless(time_of_day(night))
    ], Answer).

evalDrink(camomile, Answer) :-
    baseEvalDrink(camomile, [
        parameterless(time_of_day(afternoon))
    ], Answer).

evalDrink(camomile, Answer) :-
    baseEvalDrink(camomile, [
        parameterless(time_of_day(\+afternoon)),
        regeval(stress(high)),
        regeval(company(none)),
        regeval(no_alergy(camomile))
    ], Answer).

evalDrink(mint, Answer) :-
    baseEvalDrink(mint, [
        regeval(stomach_ache(true)),
        regeval(like(hot))
    ], Answer).

evalDrink(cola, Answer) :-
    baseEvalDrink(cola, [
        regeval(stomach_ache(true)),
        regeval(like(cold))
    ], Answer).

evalDrink(orange_juice, Answer) :-
    baseEvalDrink(orange_juice, [
        subeval(juice),
        regeval(like(orange))
    ], Answer).

evalDrink(apple_juice, Answer) :-
    baseEvalDrink(apple_juice, [
        subeval(juice),
        regeval(like(apple))
    ], Answer).

evalDrink(lemonade, Answer) :-
    baseEvalDrink(lemonade, [
        subeval(juice),
        regeval(like(lemon))
    ], Answer).

evalDrink(juice, Answer) :-
    baseEvalDrink(juice, [
        regeval(like(juice))
    ], Answer).

evalDrink(water, Answer) :-
    baseEvalDrink(water, [
        regeval(like(water))
    ], Answer).

evalDrink(default, Answer) :-
    baseEvalDrink(none, [], Answer).

weather(warm, _, _) :- season(summer).

weather(warm, Answer, ReturnFlag) :- evalPositive([weather, warm], Answer, ReturnFlag).

weather(cold, _, _) :- season(winter).

weather(cold, Answer, ReturnFlag) :- negative([weather, warm], Answer, ReturnFlag).

tiredness(high, Answer, ReturnFlag) :- evalPositive([tiredness,high], Answer, ReturnFlag).

weekend() :- day_of_week(X), member(X, [friday, saturday, sunday]).

stress(high, Answer, ReturnFlag) :- evalPositive([stress, high], Answer, ReturnFlag).

stress(low, Answer, ReturnFlag) :- evalNegative([stress, high], Answer, ReturnFlag).

company(none, Answer, ReturnFlag) :- epositive([company, none], Answer, ReturnFlag).

company(few, Answer, ReturnFlag) :- evalPositive([company, few], Answer, ReturnFlag).

company(one, Answer, ReturnFlag) :- evalPositive([company, one], Answer, ReturnFlag).

stomach_ache(true, Answer, ReturnFlag) :- evalPositive([stomach_ache, sensible], Answer, ReturnFlag).

stomach_ache(false, Answer, ReturnFlag) :- evalNegative([stomach_ache, sensible], Answer, ReturnFlag).

alergy(camomile, Answer, ReturnFlag) :- evalPositive([alergy, camomile], Answer, ReturnFlag).

alergy(lactose, Answer, ReturnFlag) :- evalPositive([alergy, lactose], Answer, ReturnFlag).

no_alergy(camomile, Answer, ReturnFlag) :- evalNegative([alergy, camomile], Answer, ReturnFlag).

no_alergy(lactose, Answer, ReturnFlag) :- evalNegative([alergy, lactose], Answer, ReturnFlag).

like(X, Answer, ReturnFlag) :- evalPositive([like, X], Answer, ReturnFlag).

/*
    Time functions
*/

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

/*
    Api functions
*/


initialize() :-
    retractall(xpositive(_)),
    retractall(xnegative(_)).

evalPositive(X, _, _) :-
    xpositive(X),
    !.

evalPositive(X, Answer, ReturnFlag) :-
    \+xnegative(X),
    ReturnFlag = true,
    Answer = question(X, like),
    true.

evalNegative(X, _, _) :-
    xnegative(X),
    !.

evalNegative(X, Answer, ReturnFlag) :-
    \+xpostive(X),
    ReturnFlag = true,
    Answer = question(X, not_like),
    true.

consultDrink(Answer) :-
    evalDrink(_, Answer).

remember(X, like, true) :- assertz(xpositive(X)).

remember(X, like, false) :- assertz(xnegative(X)).

remember(X, not_like, true) :- assertz(xnegative(X)).

remember(X, not_like, false) :- assertz(xpositive(X)).

answer(question(X, Y), Boolean) :-
    remember(X, Y, Boolean).

