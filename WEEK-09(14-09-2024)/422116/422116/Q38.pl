modify_list([], N, X, []).
modify_list([H|T], 0, X, [X|T]).
modify_list([H|T], N, X, [H|Y]) :- 
    N > 0, 
    N1 is N - 1, 
    modify_list(T, N1, X, Y).