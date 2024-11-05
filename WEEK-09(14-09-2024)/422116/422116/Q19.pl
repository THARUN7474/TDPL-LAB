memberx(N,[N|T]).
memberx(N,[X|T]):-memberx(N,T).
delete_unique([],[]).
delete_unique([H|T],[H|Y]):-memberx(H,T),!,delete_unique(T,Y).
delete_unique([H|T],Y):-delete_unique(T,Y).