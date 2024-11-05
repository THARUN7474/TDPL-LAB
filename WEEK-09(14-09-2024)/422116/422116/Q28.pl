reverse([], []).
reverse([H|T], K) :-
    reverse(T, RevT),
    append(RevT, [H], K).
