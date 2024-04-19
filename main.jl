using LinearAlgebra

function arePointsOnLine(coords)
    x, y, z = coords[1, 1], coords[1, 2], coords[1, 3]
    x1, y1, z1 = coords[2, 1], coords[2, 2], coords[2, 3]
    x2, y2, z2 = coords[3, 1], coords[3, 2], coords[3, 3]
    if ((x == x1) && (y == y1) && (z == z1)) || ((x == x2) && (y == y2) && (z == z2)) || ((x1 == x2) && (y1 == y2) && (z1 == z2))
        return true
    elseif (x - x1) / (x2 - x1) == (y - y1) / (y2 - y1) == (z - z1) / (z2 - z1)
        return true
    end
    return false
end

function areVectorsPerpendicular(firstPoint, secondPoint, thirdPoint)
    vector1 = secondPoint - firstPoint
    vector2 = thirdPoint - firstPoint
    if (dot(vector1, vector2) == 0)
        return true
    end
    return false
end

name_coords = ["A", "B", "C"]
coords = [0 0 0; 0 0 0; 0 0 0]
for i in 1:3
    print(name_coords[i] * " = ")
    input_coords = split(readline())
    for j in 1:3
        coords[i, j] = parse(Int64, input_coords[j])
    end
end

if arePointsOnLine(coords)
    println("Points are on one line")
else
    println("Points are not on one line")
end

println(areVectorsPerpendicular([coords[1, 1] coords[1, 2] coords[1, 3]], [coords[2, 1] coords[2, 2] coords[2, 3]], [coords[3, 1] coords[3, 2] coords[3, 3]]))
