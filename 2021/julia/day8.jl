function part1()
    tot = 0
    @inbounds for line in eachline("../data/input8.txt")
        _, final = split(line, " | ")
        segs = split(final)
        tot += count(x -> length(x) in (2, 4, 7, 3), segs)
    end
    return tot
end

function part2()
    tot = 0
    sum2digit = Dict(42 => 0, 17 => 1, 34 => 2, 39 => 3, 30 => 4, 37 => 5, 41 => 6, 25 => 7, 49 => 8, 45 => 9)

    @inbounds for line in eachline("../data/input8.txt")
        initial, final = split(line, " | ")

        freqs = Dict()
        for c in "abcdefg"
            freqs[c] = count(==(c), initial)
        end

        segs_o = split(final)
        for (i, seg) in enumerate(segs_o)
            digit = sum2digit[sum(freqs[c] for c in seg)]
            tot += digit * 10^(4-i)
        end
    end
    return tot
end
