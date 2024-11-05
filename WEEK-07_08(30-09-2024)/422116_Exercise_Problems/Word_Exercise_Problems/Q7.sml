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

fun primes(nums: int list) =
    List.filter isPrime nums

val result = primes([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
