add_up_list(L, K) :- add_up_list(L, 0, K).

add_up_list([], _, []).
add_up_list([H|T], Acc, [Sum|K]) :-
    Sum is Acc + H,
    add_up_list(T, Sum, K).
