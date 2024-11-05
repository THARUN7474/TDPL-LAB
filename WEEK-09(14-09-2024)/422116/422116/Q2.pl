addtoend(H,[],[H]).
addtoend(X,[H|T],[H|T1]):-addtoend(X,T,T1).
reversex([],[]).
reversex([H|T],Y):- reversex(T,T1), addtoend(H,T1,Y).