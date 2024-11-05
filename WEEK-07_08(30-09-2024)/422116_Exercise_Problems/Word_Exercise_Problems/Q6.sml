fun occr([], _) = 0
  | occr(x::xs, y) = (if x = y then 1 else 0) + occr(xs, y)

val nums = [1, 2, 3, 2, 4, 2]
val count = occr(nums, 2)
