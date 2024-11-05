sumlist([], 0).
sumlist([H|T], N) :-
    sumlist(T, SumT),
    N is H + SumT.
