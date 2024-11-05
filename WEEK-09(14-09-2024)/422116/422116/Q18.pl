memberx(N,[N|T]).
memberx(N,[X|T]):-memberx(N,T).
deleteall(N,[],[]).
deleteall(N,[N|T],U):-!,deleteall(N,T,U).
deleteall(N,[H|T],[H|U]):-deleteall(N,T,U).
delete_dupl([],[]).
delete_dupl([H|T],Y):-memberx(H,T),!,deleteall(H,T,T1),delete_dupl(T1,Y).
delete_dupl([H|T],[H|Y]):-delete_dupl(T,Y).