val i = ref 10
val _ = (i := !i + 1)
val _ = (i := !i - 1)
val _ = (i := 20)
val finalValue = !i