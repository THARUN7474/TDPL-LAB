fun f (x, y, z, t) =
    if x = y then z + 1
    else if x > y then z
    else y + t;

(*
    Justification:
    - The function evaluates to an integer value based on the conditions applied to x and y.
    - If the types of x and y are not restricted to integers, the function could potentially be generalized
    with type variables like this:
        - f : 'a * 'a * int * int -> int
    - This means x and y could be of any type, but z and t must remain integers for the arithmetic operations to be 
    valid.
*)