function parse_input()
    points = NTuple{4, Int}[]
    h = 0
    w = 0
    @inbounds for line in eachline("../data/input5.txt")
        p1, p2 = split(line, " -> ")
        x1, y1 = parse.(Int, split(p1, ","))
        x2, y2 = parse.(Int, split(p2, ","))
        w = max(x1, x2, w)
        h = max(y1, y2, h)
        push!(points, (x1, x2, y1, y2))
    end
    return points, w + 1, h + 1
end

function day5_part1()
    points, w, h = parse_input()
    occupied = zeros(Int, h+1, w+1)
    numcrowded = 0
    @inbounds for (x1, x2, y1, y2) in points
        if x1 == x2 || y1 == y2
            d = max(abs(x2 - x1), abs(y2 - y1))
            dx = sign(x2 - x1)
            dy = sign(y2 - y1)
            for step in 0:d
                xidx = x1 + dx * step + 1
                yidx = y1 + dy * step + 1
                occupied[yidx, xidx] += 1
                numcrowded += occupied[yidx, xidx] == 2
            end
        end
    end
    return numcrowded
end

function day5_part2()
    points, w, h = parse_input()
    occupied = zeros(Int, h+1, w+1)
    numcrowded = 0
    @inbounds for (x1, x2, y1, y2) in points
        d = max(abs(x2 - x1), abs(y2 - y1))
        dx = sign(x2 - x1)
        dy = sign(y2 - y1)
        for step in 0:d
            xidx = x1 + dx * step + 1
            yidx = y1 + dy * step + 1
            occupied[yidx, xidx] += 1
            numcrowded += occupied[yidx, xidx] == 2
        end
    end
    return numcrowded
end
