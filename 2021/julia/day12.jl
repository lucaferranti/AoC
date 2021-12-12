function build_graph(fname)
    graph = Dict{String, Vector{String}}()
    for line in eachline(fname)
        node1, node2 = split(line, "-")

        if haskey(graph, node1)
            push!(graph[node1], node2)
        else
            graph[node1] = [node2]
        end

        if haskey(graph, node2)
            push!(graph[node2], node1)
        else
            graph[node2] = [node1]
        end
    end
    return graph
end


function part1(g, src="start", npaths=0, visited=Set{String}())

    src == "end" && (return npaths += 1)
    all(islowercase, src) && push!(visited, src)

    for sink in g[src]
        sink ∉ visited && (npaths = enumerate_paths!(g, sink, npaths, visited))
    end

    src ∈ visited && delete!(visited, src)

    return npaths
end

function part2(g, src="start", npaths=0, visited=Set{String}(), twice=[""])
    src == "end" && (return npaths += 1)
    all(islowercase, src) && push!(visited, src)

    for sink in g[src]
        if sink ∉ visited
            npaths = part2(g, sink, npaths, visited, twice)
        elseif twice[1] == ""
            sink == "start" && continue
            twice[1] = sink
            npaths = part2(g, sink, npaths, visited, twice)
        end
    end

    if src ∈ visited
        if src == twice[1]
            twice[1] = ""
        else
            delete!(visited, src)
        end
    end
    return npaths
end

g = build_graph("../data/input12.txt")
@show part1(g)
@show part2(g)
