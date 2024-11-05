fun reverse([]) = []
  | reverse(x :: xs) = reverse(xs) @ [x]

val result = reverse([1, 5, 4])
