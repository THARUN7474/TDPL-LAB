fun perfect(x: int): bool =
    let
        fun sumOfDivisors(n: int, divisor: int): int =
            if divisor >= n then 0
            else if n mod divisor = 0 then divisor + sumOfDivisors(n, divisor + 1)
            else sumOfDivisors(n, divisor + 1)
    in
        x > 0 andalso sumOfDivisors(x, 1) = x
    end

val test1 = perfect(6)
val test2 = perfect(28)
val test3 = perfect(12)
