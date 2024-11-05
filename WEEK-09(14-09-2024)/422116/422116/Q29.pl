nth(1, [H|_], H).
nth(N, [_|T], TheItem) :-
    N > 1,
    N1 is N - 1,
    nth(N1, T, TheItem).
