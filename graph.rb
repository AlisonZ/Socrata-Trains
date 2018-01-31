class Node
    attr_accessor :name, :visited

    def initialize(name)
        @name = name
        @visited = false
    end
end

class Edge
    attr_accessor :origin, :destination, :weight, :next

    def initialize(origin, destination, weight)
        @origin = origin
        @destination = destination
        @weight = weight
        @next = false
    end

# TODO: remove this function if it does not end up being used recursively
# can do the same thing now as just updating the .next feature of the edge currently on
    def add_next(edge)
        self.next = edge
        return edge
    end
end


class Graph
    attr_accessor :routeHash

    def initialize
        self.routeHash = {}
    end

    def numStops(start, final, maxStops)
        # puts final
        return findRoutes(start, final, 0, maxStops)
    end

    def findRoutes(start, final, depth, maxStops)
        # TODO: make this a helper function find_node
        self.routeHash.each do |key, value|
            if key.name === start
                start = key
            end
        end
        # counter to keep track of how many routes meet the criteria
        routes = 0

        # # keeps track of stops in current route traversal
        depth +=1
        # need to wrap this in an if statement that checks for start and end
        # if no start and end, put NO SUCH ROUTE
        if depth > maxStops
            return routes
        else
            start.visited = true
            edge = self.routeHash[start]

             if edge
                if edge.destination.name === final
                    routes +=1
                    edge = edge.next
                    depth+=1

                elsif !edge.destination.visited
                    routes +=1
                    routes +=self.findRoutes(edge.destination.name, final, depth, maxStops)
                    depth -=1
                end
                edge = edge.next
            end
        end

        start.visited = false
        return routes
    end
end

# TODO: clean this up. working now, but only for this problem set. should be nice and recursive
def make_graph()
    g = Graph.new
    list = create_graph_list('./input.txt')

    list.each do |route|
        if g.routeHash[route[0]]
            if g.routeHash[route[0]].next === false
                g.routeHash[route[0]].add_next(Edge.new(route[0], route[1], route[2].to_i))
            else
                # this works for this specific input, but wouldn't work with another next loop
                # make this recursive and work for real, not hacky
                # until .next != false keep putting node.next into the checker and then call add_next on it
                g.routeHash[route[0]].next.add_next(Edge.new(route[0], route[1], route[2].to_i))
            end
        else
            g.routeHash[route[0]] = Edge.new(route[0], route[1], route[2].to_i)
        end
    end

    return g

end

def create_graph_list(file_path)
    File.open(file_path, 'r') do |f|
        f.each_line do |line|
            return graph_list = line.split(",").map(&:strip)
        end
    end
end


# g = make_graph()

# # MANUALLY ADDS THE NODES AND EDGES
g = Graph.new
graph_list = ["AB5", "BC4", "CD8", "DC8", "DE6", "AD5", "CE2", "EB3", "AE7"]
A = Node.new("A")
B = Node.new("B")
C = Node.new("C")
D = Node.new("D")
E = Node.new("E")


g.routeHash[A] = Edge.new(A, B, 5)
g.routeHash[A].add_next(Edge.new(A, D, 5))
g.routeHash[A].next.add_next(Edge.new(A, E, 7))
g.routeHash[B] = Edge.new(B, C, 4)
g.routeHash[C] = Edge.new(C, D, 8)
g.routeHash[C].add_next(Edge.new(C, E, 2))
g.routeHash[D] = Edge.new(D, C, 8)
g.routeHash[D].add_next(Edge.new(D, E, 6))
g.routeHash[E] = Edge.new(E, B, 3)

# puts g.routeHash
puts g.numStops("C", "C", 3)

# puts g.routeHash["A"].destination
