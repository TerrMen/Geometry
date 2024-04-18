function arePointsOnLine(coords)
    x, y, z = coords[1, 1], coords[1, 2], coords[1, 3]
    x1, y1, z1 = coords[2, 1], coords[2, 2], coords[2, 3]
    x2, y2, z2 = coords[3, 1], coords[3, 2], coords[3, 3]
    # if ((x == x1) && (y == y1) && (z == z1)) || ((x == x2) && (y == y2) && (z == z2)) || ((x1 == x2) && (y1 == y2) && (z1 == z2))
    #     return true
    # end
    if (x - x1) / (x2 - x1) == (y - y1) / (y2 - y1) == (z - z1) / (z2 - z1)
        return true
    end
    return false
end

name_coords = ["A", "B", "C"]
coords = hcat([0, 0, 0], [0, 0, 0], [0, 0, 0])
for i in 1:3
    print(name_coords[i] * " = ")
    input_coords = split(readline())
    for j in 1:3
        coords[i, j] = parse(Int64, input_coords[j])
    end
end
println(arePointsOnLine(coords))
