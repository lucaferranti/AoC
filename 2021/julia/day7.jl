function day7()
nums = parse.(Int, split(readline("../data/input7.txt"), ","))

xmax = maximum(nums)
minimiser2 = Inf
cost2 = Inf
med = Int(round(median(nums)))
cost1 = sum(abs(med - n) for n in nums)
@inbounds for x in 0:xmax
    d2 = sum((x-i)^2+abs(x-i) for i in nums)
    if d2 < cost2
        cost2 = d2
        minimiser2 = x
    end
end
return cost1, cost2÷2
end
