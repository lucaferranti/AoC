using DataStructures # needed for PriorityQueue

s = readlines("../data/input15.txt")
N =  length(s)
A = zeros(Int, N, N)
@inbounds for i in 1:N
    for j in 1:N
        A[j, i] = parse(Int, s[j][i])
    end
end

function part1(grid)
    row, col = size(grid)
    dis = fill(typemax(Int), row, col)
    dx = (-1, 0, 1, 0)
    dy = (0, 1, 0, -1)

    st = PriorityQueue{Tuple{Int, Int}, Int}()
    st[(1, 1)] = 0
    dis[1, 1] = grid[1, 1]
    while !isempty(st)
        (kx, ky), _ = peek(st)
        dequeue!(st)

        @inbounds for i in 1:4
            x = kx + dx[i]
            y = ky + dy[i]
            (1 <= x <= col && 1 <= y <= row) || continue

            dcand = dis[ky, kx] + grid[y, x]
            if dis[y, x] > dcand
                dis[y, x] = dcand
                st[(x, y)] = dis[y, x]
            end
        end
    end
    return dis[end, end] - grid[1, 1]
end


function part2(grid)
    row, col = size(grid)
    row2 = 5*row
    col2 = 5*col
    dis = fill(typemax(Int), row2, col2)
    dx = (-1, 0, 1, 0)
    dy = (0, 1, 0, -1)

    st = PriorityQueue{Tuple{Int, Int}, Int}()
    st[(1, 1)] = 0
    dis[1, 1] = grid[1, 1]
    while !isempty(st)
        (kx, ky), _ = peek(st)
        dequeue!(st)

        @inbounds for i in 1:4
            x = kx + dx[i]
            y = ky + dy[i]
            (1 <= x <= col2 && 1 <= y <= row2) || continue

            dcand = mod1(grid[mod1(y, row), mod1(x, col)] + (x-1)÷col + (y-1)÷row, 9)
            dcand += dis[ky, kx]
            if dis[y, x] > dcand
                dis[y, x] = dcand
                st[(x, y)] = dis[y, x]
            end
        end
    end
    return dis[end, end] - grid[1, 1]
end
