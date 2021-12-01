using BenchmarkTools
s = read("../data/input1.txt", String)
arr = parse.(Int, split(s))

part1(arr) = count(i -> arr[i+1] > arr[i], 1:length(arr)-1)

@show part1(arr)
@btime part1($arr)

part2(arr) = count(i -> arr[i+3] > arr[i], 1:length(arr)-3)

@show part2(arr)
@btime part2($arr)
