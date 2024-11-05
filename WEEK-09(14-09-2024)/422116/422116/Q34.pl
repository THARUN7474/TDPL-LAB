factorial(0, 1).
factorial(N, X) :- N > 0, 
                   N1 is N - 1, 
                   factorial(N1, S), 
                   X is S * N.
