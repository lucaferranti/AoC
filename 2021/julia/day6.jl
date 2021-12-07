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
