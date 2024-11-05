memberx(N, [N|_]).
memberx(N, [_|T]) :- 
    memberx(N, T).
deleteall(_, [], []).
deleteall(N, [N|T], U) :- 
    !, 
    deleteall(N, T, U).
deleteall(N, [H|T], [H|U]) :- 
    deleteall(N, T, U).
make_unique([], []).
make_unique([H|T], Y) :- 
    memberx(H, T), 
    !, 
    deleteall(H, T, T1), 
    make_unique(T1, Y).
make_unique([H|T], [H|Y]) :- 
    make_unique(T, Y).
