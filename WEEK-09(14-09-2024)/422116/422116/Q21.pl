quicksort([], []).
quicksort([H|T], Sorted) :-
    partition(H, T, L1, L2),
    quicksort(L1, Sorted1),
    quicksort(L2, Sorted2),
    append(Sorted1, [H|Sorted2], Sorted).

partition(_, [], [], []).
partition(Pivot, [H|T], [H|L1], L2) :-
    H =< Pivot,
    partition(Pivot, T, L1, L2).
partition(Pivot, [H|T], L1, [H|L2]) :-
    H > Pivot,
    partition(Pivot, T, L1, L2).
