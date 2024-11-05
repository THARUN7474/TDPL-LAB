reversex([], []).
reversex([H|T], X) :-
    reversex(T, RevT),
    append(RevT, [H], X).
