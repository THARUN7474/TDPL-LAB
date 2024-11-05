remove_nth(1, [_|T], T).
remove_nth(N, [H|T], [H|R]) :-
    N > 1,
    N1 is N - 1,
    remove_nth(N1, T, R).
remove_nth(_, [], []) :- fail.
insert_nth(1, X, L, [X|L]).
insert_nth(N, X, [H|T], [H|R]) :-
    N > 1,
    N1 is N - 1,
    insert_nth(N1, X, T, R).
insert_nth(_, _, [], _) :- fail.
