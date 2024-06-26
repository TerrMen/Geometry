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

function setCoords()
    name_coords = ["A", "B", "C"]
    coords = [0.0 0.0 0.0; 0.0 0.0 0.0; 0.0 0.0 0.0]
    for i in 1:3
        print(name_coords[i] * " = ")
        input_coords = split(readline())
        for j in 1:3
            coords[i, j] = parse(Float64, input_coords[j])
        end
    end
    return [coords[1, 1] coords[1, 2] coords[1, 3]], [coords[2, 1] coords[2, 2] coords[2, 3]], [coords[3, 1] coords[3, 2] coords[3, 3]]
end

function buildBase(firstPoint, secondPoint, extraPoint)
    norma = norm(vec(secondPoint - firstPoint))
    AB = vec(secondPoint - firstPoint)
    AC = vec(extraPoint - firstPoint)
    vector = cross(AB, cross(AC, AB))
    vector = vector / norm(vector) * norma
    thirdPoint = vec(firstPoint) + vector
    fourthPoint = thirdPoint + AB

    height = cross(AB, vector)
    height = height / norm(height) * norma

    return thirdPoint, fourthPoint, height
end

function buildCube(firstPoint, secondPoint, extraPoint)
    thirdPoint, fourthPoint, height = buildBase(firstPoint, secondPoint, extraPoint)
    fifthPoint = vec(firstPoint) + height
    sixthPoint = vec(secondPoint) + height
    seventhPoint = vec(thirdPoint) + height
    eighthPoint = vec(fourthPoint) + height

    drawCube(firstPoint, secondPoint, thirdPoint, fourthPoint, 
    fifthPoint, sixthPoint, seventhPoint, eighthPoint)
end

function drawCube(firstPoint, secondPoint, thirdPoint, fourthPoint, 
    fifthPoint, sixthPoint, seventhPoint, eighthPoint)
    x = [firstPoint[1], secondPoint[1], thirdPoint[1], fourthPoint[1],
    fifthPoint[1], sixthPoint[1], seventhPoint[1], eighthPoint[1]]
    y = [firstPoint[2], secondPoint[2], thirdPoint[2], fourthPoint[2],
    fifthPoint[2], sixthPoint[2], seventhPoint[2], eighthPoint[2]]

    minx = min(firstPoint[1], secondPoint[1], thirdPoint[1], fourthPoint[1],
    fifthPoint[1], sixthPoint[1], seventhPoint[1], eighthPoint[1])
    maxx = max(firstPoint[1], secondPoint[1], thirdPoint[1], fourthPoint[1],
    fifthPoint[1], sixthPoint[1], seventhPoint[1], eighthPoint[1])
    miny = min(firstPoint[2], secondPoint[2], thirdPoint[2], fourthPoint[2],
    fifthPoint[2], sixthPoint[2], seventhPoint[2], eighthPoint[2])
    maxy = max(firstPoint[2], secondPoint[2], thirdPoint[2], fourthPoint[2],
    fifthPoint[2], sixthPoint[2], seventhPoint[2], eighthPoint[2])

    cube = scatter(x, y, xlim=(minx - 1, maxx + 1), ylim=(miny - 1, maxy + 1), label="")
    plot!([firstPoint[1], secondPoint[1], fourthPoint[1], thirdPoint[1], firstPoint[1]], 
    [firstPoint[2], secondPoint[2], fourthPoint[2], thirdPoint[2], firstPoint[2]], label="")
    plot!([fifthPoint[1], sixthPoint[1], eighthPoint[1], seventhPoint[1], fifthPoint[1]], 
    [fifthPoint[2], sixthPoint[2], eighthPoint[2], seventhPoint[2], fifthPoint[2]], label="")
    plot!([firstPoint[1], fifthPoint[1]], [firstPoint[2], fifthPoint[2]], label="")
    plot!([secondPoint[1], sixthPoint[1]], [secondPoint[2], sixthPoint[2]], label="")
    plot!([thirdPoint[1], seventhPoint[1]], [thirdPoint[2], seventhPoint[2]], label="")
    plot!([fourthPoint[1], eighthPoint[1]], [fourthPoint[2], eighthPoint[2]], label="")

    for i in 1:8
        annotate!(x[i], y[i] + 0.35, ("(" * string(round(x[i], digits=2)) * ", " * string(round(y[i], digits=2)) * ")", 9, :black))
    end

    title!("cube")
    return cube
end

function buildPyramid(firstPoint, secondPoint, extraPoint)
    thirdPoint, fourthPoint, height = buildBase(firstPoint, secondPoint, extraPoint)
    height *= (sqrt(2) / 2)
    middlePoint = (fourthPoint + vec(firstPoint)) / 2
    fifthPoint = middlePoint + height

    drawPyramid(firstPoint, secondPoint, thirdPoint, fourthPoint, fifthPoint)
end

function drawPyramid(firstPoint, secondPoint, thirdPoint, fourthPoint, fifthPoint)
    x = [firstPoint[1], secondPoint[1], thirdPoint[1], fourthPoint[1], fifthPoint[1]]
    y = [firstPoint[2], secondPoint[2], thirdPoint[2], fourthPoint[2], fifthPoint[2]]
    minx = min(firstPoint[1], secondPoint[1], thirdPoint[1], fourthPoint[1], fifthPoint[1])
    maxx = max(firstPoint[1], secondPoint[1], thirdPoint[1], fourthPoint[1], fifthPoint[1])
    miny = min(firstPoint[2], secondPoint[2], thirdPoint[2], fourthPoint[2], fifthPoint[2])
    maxy = max(firstPoint[2], secondPoint[2], thirdPoint[2], fourthPoint[2], fifthPoint[2])

    pyramid = scatter(x, y, xlim=(minx - 1, maxx + 1), ylim=(miny - 1, maxy + 1), label="")
    plot!([firstPoint[1], secondPoint[1], fourthPoint[1], thirdPoint[1], firstPoint[1]],
    [firstPoint[2], secondPoint[2], fourthPoint[2], thirdPoint[2], firstPoint[2]], label="")
    plot!([firstPoint[1], fifthPoint[1], fourthPoint[1]], 
    [firstPoint[2], fifthPoint[2], fourthPoint[2]], label="")
    plot!([secondPoint[1], fifthPoint[1], thirdPoint[1]], 
    [secondPoint[2], fifthPoint[2], thirdPoint[2]], label="")

    for i in 1:5
        annotate!(x[i], y[i] + 0.35, ("(" * string(round(x[i], digits=2)) * ", " * string(round(y[i], digits=2)) * ")", 9, :black))
    end

    title!("pyramid")
    return pyramid
end

function buildTetrahedron(firstPoint, secondPoint, extraPoint)
    norma = norm(vec(secondPoint - firstPoint))
    AB = vec(secondPoint - firstPoint)
    AC = vec(extraPoint - firstPoint)
    vector = cross(AB, cross(AC, AB))
    vector = vector / norm(vector) * norma
    middleAB = (firstPoint + secondPoint) / 2
    vector = vector * (sqrt(3) / 2)
    thirdPoint = vec(middleAB) + vector

    middlePoint = (vec(firstPoint) + vec(secondPoint) + thirdPoint) / 3
    height = cross(AB, vector)
    height = height / norm(height) * (norma * (sqrt(6) / 3))
    fourthPoint = middlePoint + height

    drawTetrahedron(firstPoint, secondPoint, thirdPoint, fourthPoint)
end

function drawTetrahedron(firstPoint, secondPoint, thirdPoint, fourthPoint)
    x = [firstPoint[1], secondPoint[1], thirdPoint[1], fourthPoint[1]]
    y = [firstPoint[2], secondPoint[2], thirdPoint[2], fourthPoint[2]]
    minx = min(firstPoint[1], secondPoint[1], thirdPoint[1], fourthPoint[1])
    maxx = max(firstPoint[1], secondPoint[1], thirdPoint[1], fourthPoint[1])
    miny = min(firstPoint[2], secondPoint[2], thirdPoint[2], fourthPoint[2])
    maxy = max(firstPoint[2], secondPoint[2], thirdPoint[2], fourthPoint[2])

    tetrahedron = scatter(x, y, xlim=(minx - 1, maxx + 1), ylim=(miny - 1, maxy + 1), label="")
    plot!([firstPoint[1], secondPoint[1], thirdPoint[1], firstPoint[1]],
    [firstPoint[2], secondPoint[2], thirdPoint[2], firstPoint[2]], label="")
    plot!([firstPoint[1], fourthPoint[1]], [firstPoint[2], fourthPoint[2]], label="")
    plot!([secondPoint[1], fourthPoint[1]], [secondPoint[2], fourthPoint[2]], label="")
    plot!([thirdPoint[1], fourthPoint[1]], [thirdPoint[2], fourthPoint[2]], label="")

    for i in 1:4
        annotate!(x[i], y[i] + 0.35, ("(" * string(round(x[i], digits=2)) * ", " * string(round(y[i], digits=2)) * ")", 9, :black))
    end

    title!("tetrahedron")
    return tetrahedron
end

firstPoint, secondPoint, extraPoint = setCoords()

if arePointsOnLine(firstPoint, secondPoint, extraPoint)
    println("Points are on one line")
else
    plot(buildCube(firstPoint, secondPoint, extraPoint),
    buildPyramid(firstPoint, secondPoint, extraPoint),
    buildTetrahedron(firstPoint, secondPoint, extraPoint), size=(1000, 1000))
end