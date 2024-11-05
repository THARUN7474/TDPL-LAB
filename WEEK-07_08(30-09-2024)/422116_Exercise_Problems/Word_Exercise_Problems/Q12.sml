fun digits(n: int) : int list =
    let
        fun helper(0, acc) = acc
          | helper(x, acc) = helper(x div 10, (x mod 10) :: acc)
    in
        helper(n, [])
    end

val result = digits(253)