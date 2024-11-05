encapsulate([],[]).
encapsulate([H|T],[[H]|Y]):-encapsulate(T,Y).