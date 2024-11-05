insert_zeros([], []).
insert_zeros([H|T], [H, 0 | Y]) :- insert_zeros(T, Y).
