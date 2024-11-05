increment([],[]).
increment([H|T],[X|Y]):-increment(T,Y),X is H+1.