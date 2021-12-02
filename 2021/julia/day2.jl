using BenchmarkTools

function solve_day2()
    x, d1, d2, aim = 0, 0, 0, 0
    @inbounds for line in eachline("../data/input2.txt")
        command, vals = split(line)
        val = parse(Int, vals)
        if startswith(command, 'f') # forward
            x += val
            d2 += aim * val
        elseif startswith(command, 'd') # down
            aim += val
            d1 += val
        else # up
            aim -= val
            d1 -= val
        end
    end
    return x * d1, x * d2
end

@show solve_day2()
@btime solve_day2()
