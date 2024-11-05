fun afficher(i: int) =
    print (Int.toString(i) ^ "\n")

fun loop(i: int) =
    if i <= 0 then
        ()
    else (
        afficher(i);
        loop(i - 1)
    )

val _ = loop(1)
