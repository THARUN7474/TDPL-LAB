exception NegativeInput

fun factorial(n: int): int =
    if n < 0 then raise NegativeInput
    else if n = 0 then 1
    else n * factorial(n - 1)

val test1 = factorial(0)
val test2 = factorial(5)

val result =
    (factorial (~5) handle
        NegativeInput => 0
      | exn => raise exn)
