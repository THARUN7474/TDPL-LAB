fun bubble([], acc) = (rev acc, false)
  | bubble([x], acc) = (rev (x::acc), false)
  | bubble(x::y::xs, acc) =
      if x > y then bubble(x::xs, y::acc)
      else bubble(y::xs, x::acc);

fun is_sorted [] = true
  | is_sorted [x] = true
  | is_sorted (x::y::xs) = (x <= y) andalso is_sorted(y::xs);

fun iteration(lst) =
    if is_sorted lst then lst
    else let val (new_lst, _) = bubble(lst, [])
         in iteration(new_lst)
         end;

fun bubble_sort(lst) = iteration(lst);

val sortedList = bubble_sort([3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]); 