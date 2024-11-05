fun is_prime(x: int): bool =
    let
        fun check(n, d) =
            if d * d > n then true
            else if n mod d = 0 then false
            else check(n, d + 1)
    in
        if x < 2 then false
        else check(x, 2)
    end

val test1 = is_prime(7)
val test2 = is_prime(10)
