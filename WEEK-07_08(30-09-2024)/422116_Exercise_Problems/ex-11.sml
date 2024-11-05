fun interclass([], ys) = ys
  | interclass(xs, []) = xs
  | interclass(x::xs, y::ys) = 
      if x <= y then x :: interclass(xs, y::ys)
      else y :: interclass(x::xs, ys);

val result = interclass([1, 3, 5], [2, 4, 6]);