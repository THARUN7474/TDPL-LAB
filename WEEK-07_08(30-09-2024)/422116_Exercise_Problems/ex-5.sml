fun power_of_2 (n: int) : bool =
    let
        fun helper (x: int) =
            if x = 1 then true
            else if x < 1 then false
            else helper (x div 2)
    in
        helper n
    end;

val result = power_of_2 8;
val _ = print (Bool.toString result ^ "\n");

(*
    similar code can be converted to power of 8 by replacing 2 with 8 in line no 6 
    and replace x < 1 with x < 7 in line no 5
*)