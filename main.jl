using LinearAlgebra
using Plots

function arePointsOnLine(firstPoint, secondPoint, thirdPoint)
    x, y, z = firstPoint[1], firstPoint[2], firstPoint[3]
    x1, y1, z1 = secondPoint[1], secondPoint[2], secondPoint[3]
    x2, y2, z2 = thirdPoint[1], thirdPoint[2], thirdPoint[3]
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

function setCoords()
    name_coords = ["A", "B", "C"]
    coords = [0 0 0; 0 0 0; 0 0 0]
    for i in 1:3
        print(name_coords[i] * " = ")
        input_coords = split(readline())
        for j in 1:3
            coords[i, j] = parse(Int64, input_coords[j])
        end
    end
    return [coords[1, 1] coords[1, 2] coords[1, 3]], [coords[2, 1] coords[2, 2] coords[2, 3]], [coords[3, 1] coords[3, 2] coords[3, 3]]
end

function findHalfPlaneToSquare(firstPoint, secondPoint, thirdPoint, fourthPoint)
    AB = vec(secondPoint - firstPoint)
    AC = vec(thirdPoint - firstPoint)
    if AC == [-AB[2], AB[1], AC[3]]
        vector = cross(AC, AB)
        println(vector)
    end
end

# function findHalfPlaneToTriangle(firstPoint, secondPoint, thirdPoint)
    
# end

firstPoint, secondPoint, thirdPoint = setCoords()

if arePointsOnLine(firstPoint, secondPoint, thirdPoint)
    println("Points are on one line")
else
    if areVectorsPerpendicular(firstPoint, secondPoint, thirdPoint)
        middlePoint = (thirdPoint + secondPoint) / 2
        vector = middlePoint - firstPoint
        fourthPoint = middlePoint + vector
        findHalfPlaneToSquare(firstPoint, secondPoint, thirdPoint, fourthPoint)
        x = [firstPoint[1], secondPoint[1], thirdPoint[1], fourthPoint[1]]
        y = [firstPoint[2], secondPoint[2], thirdPoint[2], fourthPoint[2]]
    else
        x = [firstPoint[1], secondPoint[1], thirdPoint[1]]
        y = [firstPoint[2], secondPoint[2], thirdPoint[2]]
    end
    
    # plt = plot(firstPoint[1], firstPoint[2])
    scatter(x, y, label="")
end