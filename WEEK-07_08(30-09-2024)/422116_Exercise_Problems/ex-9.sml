val x = 2;
val y = x + 1;

let
    val x = x + 1
    val z = x + 4
in
    x + z
end;

let
    val t = x + 1
in
    let 
        val x = x + 1
    in
        x
    end
end;
