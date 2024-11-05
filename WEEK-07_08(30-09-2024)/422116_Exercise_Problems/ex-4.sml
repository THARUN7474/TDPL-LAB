fun replaceZeroWithX (s: string) : string =
    let
        val charList = String.explode s
        val newCharList = map (fn c => if c = #"0" then #"x" else c) charList
        val newString = String.implode newCharList
    in
        newString
    end;

val input="{a=3,b=0,c=False}"
val output=replaceZeroWithX input
val input="[-2,-2,0,1,2]"
val output=replaceZeroWithX input
val input="[(3,1),(0,9)]"
val output=replaceZeroWithX input