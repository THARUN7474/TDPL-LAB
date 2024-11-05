memberx(N,[N|T]).
memberx(N,[X|T]):-memberx(N,T).