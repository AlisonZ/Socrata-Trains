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
    puts g.routeHash
end

def create_graph_list(file_path)
    File.open(file_path, 'r') do |f|
        f.each_line do |line|
            return graph_list = line.split(",").map(&:strip)
        end
    end
end


# create_graph_list('./input.txt')
# # MANUALLY ADDS THE NODES AND EDGES
# g = Graph.new
# graph_list = ["AB5", "BC4", "CD8", "DC8", "DE6", "AD5", "CE2", "EB3", "AE7"]
# A = Node.new("A")
# B = Node.new("B")
# C = Node.new("C")
# D = Node.new("D")
# E = Node.new("E")
#
#
# g.routeHash[A] = Edge.new("A", "B", 5)
# g.routeHash[A].add_next(Edge.new("A", "D", 5))
# g.routeHash[A].next.add_next(Edge.new("A", "E", 7))
# g.routeHash[B] = Edge.new("B", "C", 4)
# g.routeHash[C] = Edge.new("C", "D", 8)
# g.routeHash[C].add_next(Edge.new("C", "E", 2))
# g.routeHash[D] = Edge.new("D", "C", 8)
# g.routeHash[D].add_next(Edge.new("D", "E", 6))
# g.routeHash[E] = Edge.new("E", "B", 3)
#
# puts g.routeHash




# g = Graph.new
# graph_list = ["AB5", "BC4", "CD8", "DC8", "DE6", "AD5", "CE2", "EB3", "AE7"]
make_graph()
