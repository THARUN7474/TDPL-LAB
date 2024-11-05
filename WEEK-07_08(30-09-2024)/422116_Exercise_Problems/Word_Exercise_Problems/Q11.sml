fun pi(a, b, f) =
    let
        fun product(x, acc) =
            if x > b then acc
            else product(x + 1, acc * f(x))
    in
        product(a, 1)
    end

val result = pi(1, 4, fn x => x * x)
