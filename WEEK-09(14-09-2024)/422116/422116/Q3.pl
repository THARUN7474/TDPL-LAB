create_list(X,X,[X]).
create_list(A,X,[A|T]):- AA is A+1, create_list(AA,X,T).