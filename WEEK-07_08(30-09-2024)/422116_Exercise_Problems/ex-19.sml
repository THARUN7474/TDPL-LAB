datatype COORDS = Point of real * real * real

fun distance (Point (x1, y1, z1), Point (x2, y2, z2)) =
    Math.sqrt (Math.pow (x2 - x1, 2.0) + Math.pow (y2 - y1, 2.0) + Math.pow (z2 - z1, 2.0))

val pointA = Point (1.0, 2.0, 3.0)
val pointB = Point (4.0, 5.0, 6.0)

val dist = distance (pointA, pointB)
