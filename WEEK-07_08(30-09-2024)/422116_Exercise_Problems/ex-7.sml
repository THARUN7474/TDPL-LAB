fun even (n: int) : bool =
    if n = 0 then true
    else odd (n - 1)

and odd (n: int) : bool =
    if n = 0 then false
    else even (n - 1)

val is_even_4 = even 4;
val is_odd_4 = odd 4;
val is_even_5 = even 5;
val is_odd_5 = odd 5;