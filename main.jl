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

function buildCube(firstPoint, secondPoint, extraPoint)
    norma = norm(vec(secondPoint - firstPoint))
    AB = vec(secondPoint - firstPoint)
    AC = vec(extraPoint - firstPoint)
    vectorForCube = cross(AB, cross(AC, AB))
    vectorForCube = vectorForCube / norm(vectorForCube) * norma
    thirdPoint = vec(firstPoint) + vectorForCube
    fourthPoint = thirdPoint + AB

    height = cross(AB, vectorForCube)
    height = height / norm(height) * norma
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
    for i in 1:8
        annotate!(x[i], y[i] + 0.2, ("(" * string(round(x[i], digits=2)) * ", " * string(round(y[i], digits=2)) * ")", 9, :black))
    end
    title!("cube")
    return cube
end

function drawPyramid(firstPoint, secondPoint, thirdPoint, fourthPoint)
    norma = norm(vec(thirdPoint - firstPoint))
    vectorProduct = findVectorProduct(firstPoint, secondPoint, thirdPoint)
    vectorForPyramid = vectorProduct / norm(vectorProduct) * (norma * sqrt(2) / 2)
    top = vec(middlePoint) + vectorForPyramid
    x = [firstPoint[1], secondPoint[1], thirdPoint[1], fourthPoint[1], top[1]]
    y = [firstPoint[2], secondPoint[2], thirdPoint[2], fourthPoint[2], top[2]]
    minx = min(firstPoint[1], secondPoint[1], thirdPoint[1], fourthPoint[1], top[1])
    maxx = max(firstPoint[1], secondPoint[1], thirdPoint[1], fourthPoint[1], top[1])
    miny = min(firstPoint[2], secondPoint[2], thirdPoint[2], fourthPoint[2], top[2])
    maxy = max(firstPoint[2], secondPoint[2], thirdPoint[2], fourthPoint[2], top[2])
    # savefig(plot(scatter(x, y, xlim=(minx - 1, maxx + 1), ylim=(miny - 1, maxy + 1), label="")))
    pyramid = scatter(x, y, xlim=(minx - 1, maxx + 1), ylim=(miny - 1, maxy + 1), label="")
    for i in 1:5
        annotate!(x[i], y[i] + 0.2, ("(" * string(round(x[i], digits=2)) * ", " * string(round(y[i], digits=2)) * ")", 9, :black))
    end
    title!("pyramid")
    return pyramid
end

function drawTetrahedron(firstPoint, secondPoint, thirdPoint)
    norma = norm(vec(thirdPoint - firstPoint))
    vectorProduct = findVectorProduct(firstPoint, secondPoint, thirdPoint)
    middlePoint = (firstPoint + secondPoint + thirdPoint) / 3
    vectorForTetrahedron = vectorProduct / norm(vectorProduct) * (norma * sqrt(6) / 3)
    top = vec(middlePoint) + vectorForTetrahedron
    x = [firstPoint[1], secondPoint[1], thirdPoint[1], top[1]]
    y = [firstPoint[2], secondPoint[2], thirdPoint[2], top[2]]
    minx = min(firstPoint[1], secondPoint[1], thirdPoint[1], top[1])
    maxx = max(firstPoint[1], secondPoint[1], thirdPoint[1], top[1])
    miny = min(firstPoint[2], secondPoint[2], thirdPoint[2], top[2])
    maxy = max(firstPoint[2], secondPoint[2], thirdPoint[2], top[2])
    # savefig(plot(scatter(x, y, xlim=(minx - 1, maxx + 1), ylim=(miny - 1, maxy + 1), label="")), "tetrahedron")
    tetrahedron = scatter(x, y, xlim=(minx - 1, maxx + 1), ylim=(miny - 1, maxy + 1), label="")
    for i in 1:4
        annotate!(x[i], y[i] + 0.2, ("(" * string(round(x[i], digits=2)) * ", " * string(round(y[i], digits=2)) * ")", 9, :black))
    end
    title!("tetrahedron")
    return tetrahedron
end

firstPoint, secondPoint, extraPoint = setCoords()

if arePointsOnLine(firstPoint, secondPoint, extraPoint)
    println("Points are on one line")
else
    plot(buildCube(firstPoint, secondPoint, extraPoint))
    # plot(drawCube(firstPoint, secondPoint, extraPoint), drawPyramid(firstPoint, secondPoint, extraPoint, fourthPoint))
    # plot(drawTetrahedron(firstPoint, secondPoint, extraPoint))
end