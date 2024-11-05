numberinlist([]):-fail.
numberinlist([X|T]):-number(X).
numberinlist([X|T]):-numberinlist(T).