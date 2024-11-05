fun subsets([]) = [[]]
  | subsets(x::xs) =
      let
          val rest_subsets = subsets(xs)
      in
          rest_subsets @ map (fn subset => x :: subset) rest_subsets
      end;

val result = subsets([1, 2, 3]);