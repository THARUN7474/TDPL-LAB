occurrences(_, [], 0).
occurrences(X, [X|T], N) :-
    occurrences(X, T, N1),
    N is N1 + 1.
occurrences(X, [_|T], N) :-
    occurrences(X, T, N).
