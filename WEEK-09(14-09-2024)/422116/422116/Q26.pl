length([], 0).
length([_|T], N) :-
    length(T, N1),
    N is N1 + 1.
