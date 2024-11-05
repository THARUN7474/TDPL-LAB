modify_list([], N, X, []).
modify_list([H|T], 0, X, [X|T]).
modify_list([H|T], N, X, [H|Y]) :- 
    N > 0, 
    N1 is N - 1, 
    modify_list(T, N1, X, Y).
addtoend(H, [], [H]).
addtoend(X, [H|T], [H|T1]) :- 
    addtoend(X, T, T1).

rotate_list([H|T], L1) :- 
    addtoend(H, T, L1).
