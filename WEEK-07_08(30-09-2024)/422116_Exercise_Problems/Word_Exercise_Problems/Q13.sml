fun digits(n: int) : int list =
    let
        fun helper(0, acc) = acc
          | helper(x, acc) = helper(x div 10, (x mod 10) :: acc)
    in
        helper(n, [])
    end

fun digitalRoot(n: int) : int =
    if n < 10 then n
    else digitalRoot(List.foldl (op +) 0 (digits(n)))

fun additivePersistence(n: int) : int =
    let
        fun helper(0, count) = count
          | helper(x, count) =
                if x < 10 then count
                else helper(digitalRoot(x), count + 1)
    in
        helper(n, 0)
    end

val resultPersistence = additivePersistence(9876)
val resultRoot = digitalRoot(9876)
