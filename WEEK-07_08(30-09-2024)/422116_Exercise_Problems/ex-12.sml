fun insert(x: int, []) = [x]
  | insert(x: int, y::ys) = 
      if x <= y then x :: y :: ys
      else y :: insert(x, ys);

fun insertion_sort([]: int list) = []
  | insertion_sort(x::xs) = insert(x, insertion_sort(xs));

val sortedList = insertion_sort([3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]); 