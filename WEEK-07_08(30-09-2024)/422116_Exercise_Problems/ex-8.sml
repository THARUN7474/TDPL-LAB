val x = 2;
val y = x + 1;

val x = 1;
local 
    val x = 2
in
    val y = x + 1
end;
val z = x + 1;

let 
    val x = 1
in 
    let
        val x = 2
        val y = x
    in
        x + y
    end
end;
