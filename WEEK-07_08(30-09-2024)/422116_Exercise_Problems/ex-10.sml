fun insert(x: int, []: int list) = [x]
  | insert(x, y::ys) = 
      if x <= y then x::y::ys
      else y::insert(x, ys);

val result = insert(5, [1, 3, 4, 6, 8]);