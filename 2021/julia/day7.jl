function day7()
    nums = parse.(Int, split(readline("../data/input7.txt"), ","))

    med = round(Int, median(nums))
    cost1 = sum(abs(med - n) for n in nums)

    μ = mean(nums)
    μ_floor = floor(Int, μ)
    μ_ceil = ceil(Int, μ)
    cost21 = sum(sum(1:abs(μ_floor - n)) for n in nums)
    cost22 = sum(sum(1:abs(μ_ceil - n)) for n in nums)

    return cost1, min(cost21, cost22)
end
