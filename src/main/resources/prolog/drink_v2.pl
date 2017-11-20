:- dynamic
    	xnegative/1,
    	xpositive/1,
    	question/2,
    	suggestedDrink/1.

baseEvalDrink(Drink, [], Answer) :-
    Answer = suggestedDrink(Drink).

baseEvalDrink(Drink, [Head | Tail], Answer) :-
    Head,
    (Answer \== ""
    ->  true
    ;   baseEvalDrink(Drink, Tail, Answer)
    ).


evalDrink(coffee, Answer) :-
    weather(warm, Answer, ReturnFlag),
    (ReturnFlag == true
        ->  true
        ;   Answer = suggestedDrink(coffee)
        ).

weather(warm, Answer, ReturnFlag) :- evalPositive([weather, warm], Answer, ReturnFlag).

weather(cold, Answer, ReturnFlag) :- evalNegative([weather, warm], Answer, ReturnFlag).

initialize() :-
    retractall(xpositive(_)),
    retractall(xnegative(_)),
    true.

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

