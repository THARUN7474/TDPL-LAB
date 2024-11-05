fun merge([], ys) = ys
  | merge(xs, []) = xs
  | merge(x :: xs, y :: ys) =
      if x < y then x :: merge(xs, y :: ys)
      else y :: merge(x :: xs, ys)

val result = merge([1, 4, 5], [2, 6, 7])
