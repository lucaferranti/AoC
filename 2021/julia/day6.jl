function day6(N)
    nums = parse.(Int, split(readline("../data/input6.txt"), ","))
    time = zeros(Int, 9)
    @inbounds for num in nums
        time[num+1] += 1
    end

    @inbounds for _ in 1:N
        time = circshift(time, -1)
        time[7] += time[end]
    end
    return sum(time)
end


nums = parse.(Int, split(readline("../data/input6.txt"), ","))

using StaticArrays
function flash_day6(N, nums)
    M = @SMatrix [0 1 0 0 0 0 0 0 0
         0 0 1 0 0 0 0 0 0
         0 0 0 1 0 0 0 0 0
         0 0 0 0 1 0 0 0 0
         0 0 0 0 0 1 0 0 0
         0 0 0 0 0 0 1 0 0
         1 0 0 0 0 0 0 1 0
         0 0 0 0 0 0 0 0 1
         1 0 0 0 0 0 0 0 0]

    time = zeros(Int, 9)
    @inbounds for num in nums
        time[num] += 1
    end
    return sum(M^N*time)
end

function part1(nums)
    M = @SMatrix [ 252   20  210   37  120   84   45  126   11
                    56  252   20  210   37  120   84   45  126
                    210   56  252   20  210   37  120   84   45
                    165  210   56  252   20  210   37  120   84
                    121  165  210   56  252   20  210   37  120
                    330  121  165  210   56  252   20  210   37
                    57  330  121  165  210   56  252   20  210
                    210   37  120   84   45  126   11  126    9
                    20  210   37  120   84   45  126   11  126]

    time = zeros(Int, 9)
    @inbounds for num in nums
        time[num+1] += 1
    end
    return sum(M*time)
end

function part2(nums)
    M = @SMatrix [  496266131  589731885  399865906  491122368  357868865
                    655568076  496266131  589731885  399865906  491122368
                    659462321  655568076  496266131  589731885  399865906
                    697451775  659462321  655568076  496266131  589731885
                    869885915  697451775  659462321  655568076  496266131
                    757734771  869885915  697451775  659462321  655568076
                    1080854253  757734771  869885915  697451775  659462321
                    399865906  491122368  357868865  378763547  339582910
                    589731885  399865906  491122368  357868865  378763547]

    time = zeros(Int, 5)
    @inbounds for num in nums
        time[num] += 1
    end
    return sum(M*time)
end

function flash_day6_part2(nums)
    magic = (6206821033,  5617089148,  5217223242,  4726100874,  4368232009)
    return sum(magic[i] for i in nums)
end

macro generate_fast_solution(N)
    M = [0 1 0 0 0 0 0 0 0
        0 0 1 0 0 0 0 0 0
        0 0 0 1 0 0 0 0 0
        0 0 0 0 1 0 0 0 0
        0 0 0 0 0 1 0 0 0
        0 0 0 0 0 0 1 0 0
        1 0 0 0 0 0 0 1 0
        0 0 0 0 0 0 0 0 1
        1 0 0 0 0 0 0 0 0]

    magic = sum(M ^ N; dims=1)
    magic = (magic[2], magic[3], magic[4], magic[5], magic[6])
    name = Symbol("day6_", N, "_days")
    code = :($name(nums) = (magic = $magic; sum(magic[i] for i in nums)))
    return esc(code)
end
