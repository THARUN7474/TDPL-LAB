fun sumOfDivisors(n: int) =
    let
        fun helper(0, acc) = acc
          | helper(i, acc) = if n mod i = 0 then helper(i - 1, acc + i) else helper(i - 1, acc)
    in
        helper(n div 2, 0)
    end

fun amicable(x: int, y: int) =
    let
        val sumX = sumOfDivisors(x)
        val sumY = sumOfDivisors(y)
    in
        (sumX = y) andalso (sumY = x) andalso (x <> y)
    end

val result = amicable(220, 284)
