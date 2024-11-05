random10(N) :- 
    random(X), 
    N is floor(X * 10).

rand_row(0, []).
rand_row(N, [H|T]) :- 
    N > 0, 
    random10(H), 
    N1 is N - 1, 
    rand_row(N1, T).

square_matrix_rand(N, S) :- 
    smr(N, N, S).

smr(N, 0, []).
smr(N, X, [R|T]) :- 
    N > 0, 
    rand_row(N, R), 
    X1 is X - 1, 
    smr(N, X1, T).
