occurs([H|_], 1, H).
occurs([_|T], N, X) :-
    N > 1,
    N1 is N - 1,
    occurs(T, N1, X).
