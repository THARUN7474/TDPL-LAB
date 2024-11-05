fun f (x, []) = []
  | f (x, a :: aa) = if x(a) then a :: f(x, aa) else f(x, aa);

(* Type Analysis *)

(* T_f = ('a -> b) * 'a list -> 'b list *)

(* 'a = T_x * T_nil *)
(* T_x = 'a -> bool *)
(* T_nil = 'a list *)

(* 'a = T_x * T_{a::aa} *)
(* T_{a::aa} = 'a * 'a list *)

(* 'b = T_nil *)
(* 'b = 'a list *)

(* 'b = T_{f(x, aa)} *)
(* T_{f(x, aa)} = 'a list *)

(* T_{x(a)} = bool *)
