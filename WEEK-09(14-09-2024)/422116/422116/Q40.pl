max1([X], X).
max1([H|T], M) :-
    max1(T, MT),
    M is max(H, MT).
