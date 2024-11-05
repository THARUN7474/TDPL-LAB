datatype person = Person of string * string * int * string

val person1 = Person ("Doe", "John", 30, "1993-01-15")

fun displayPerson (Person (lname, fname, age, dob)) =
    "Name: " ^ fname ^ " " ^ lname ^ ", Age: " ^ Int.toString(age) ^ ", Date of Birth: " ^ dob

val personInfo = displayPerson person1