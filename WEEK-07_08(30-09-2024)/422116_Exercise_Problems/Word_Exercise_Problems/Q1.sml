fun factor (x: int, y: int): bool =
    if y mod x = 0 then true
    else false

val test1 = factor(2, 8)
val test2 = factor(3, 8)