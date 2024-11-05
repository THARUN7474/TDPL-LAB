fun gcd(x: int, y: int): int =
    if y = 0 then abs(x)
    else gcd(y, x mod y)

val test1 = gcd(48, 18)
val test2 = gcd(56, 98)