fun F(op_fn, []) = raise Empty
  | F(op_fn, [x]) = x
  | F(op_fn, x::xs) = op_fn(x, F(op_fn, xs));
val lst = [1, 2, 3, 4];
val resultSum = F(op +, lst);

fun G(cond, []) = []
  | G(cond, x::xs) = if cond x then x :: G(cond, xs) else G(cond, xs);
val isEven = fn x => x mod 2 = 0;
val resultEven = G(isEven, lst);

fun max(a: int, b: int) = if a > b then a else b;
fun findMax(l: int list) = F(max, l);
val maxValue = findMax [2, 6, 3, 15, 18, 1, 55, 22];

fun conc (a: string, b: string) = a ^ b;
fun concatenate_string_list (l: string list) = F(conc, l);
val stringList = ["a", "b", "c", "d"];
val concatenatedString = concatenate_string_list stringList;

fun fold F nil y = y
    | fold F (x::l) y = F(x,(fold F l y));