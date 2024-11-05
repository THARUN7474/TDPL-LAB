fun fact n = if n = 0 then 1 else n * fact(n - 1);

fun new_if (a, b, c) = if a then b else c;

fun new_fact n = new_if (n = 0, 1, n * new_fact(n - 1));

fun new_if_lazy (a, b, c) = if a then b () else c ();

fun lazy_fact n = new_if_lazy (n = 0, (fn () => 1), (fn () => n * lazy_fact(n - 1)));

val result1 = fact 5;  
val result2 = new_if (true, "Yes", "No");  
(* val result3 = new_fact 5;  *)
val result4 = new_if_lazy (false, (fn () => "Yes"), (fn () => "No"));  
val result5 = lazy_fact 5;  