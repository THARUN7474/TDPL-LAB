fun f (x, nil) = nil
  | f (x, a :: aa) = if x(a) then x(a) :: f(x, aa) else f(x, aa);

