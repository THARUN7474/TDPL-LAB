fun isPrime(n: int) =
    if n < 2 then false
    else
        let
            fun check(i) = 
                if i * i > n then true
                else if n mod i = 0 then false
                else check(i + 1)
        in
            check(2)
        end

fun primeFactors(x: int) =
    let
        fun factor(n, d) =
            if n < 2 then []
            else if n mod d = 0 then d :: factor(n div d, d)
            else factor(n, d + 1)
    in
        factor(x, 2)
    end

val result = primeFactors(28)
