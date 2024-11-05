contains_number([H|_]) :- number(H), !.
contains_number([_|T]) :- contains_number(T).
contains_number([]) :- fail.
