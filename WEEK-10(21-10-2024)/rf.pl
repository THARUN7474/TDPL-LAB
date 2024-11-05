connected(cityA, cityB, 5).
connected(cityA, cityC, 10).
connected(cityB, cityD, 7).
connected(cityC, cityD, 3).
connected(cityC, cityE, 4).
connected(cityD, cityF, 8).
connected(cityE, cityF, 6).

path(X, Y, D) :- connected(X, Y, D).
path(X, Y, D) :- connected(Y, X, D).

route(X, Y) :-
    path(X, Y, _).
route(X, Y) :-
    path(X, Z, _),
    route(Z, Y).

find_path(X, Y, Path, Distance) :-
    find_path(X, Y, [X], Path, 0, Distance).

find_path(X, X, Visited, Path, Distance, Distance) :-
    reverse(Visited, Path).

find_path(X, Y, Visited, Path, D0, Distance) :-
    path(X, Z, D1),
    \+ member(Z, Visited),
    D2 is D0 + D1,
    find_path(Z, Y, [Z|Visited], Path, D2, Distance).

shortest_path(X, Y, Path, Distance) :-
    setof([P, D], find_path(X, Y, P, D), Paths),
    Paths = [Shortest|_],
    Shortest = [Path, Distance].
