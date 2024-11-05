sum_list([],0,0).
sum_list([H|T],Length,Sum):-sum_list(T,L1,S1), Length is L1+1, Sum is S1+H.
mean(L,M):-sum_list(L,Length,Sum), M is Sum/Length.