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
    attr_accessor :routeHash, :graphList

    def initialize
        self.routeHash = {}
        self.graphList = []
    end

    def createGraphList(file_path)
        File.open(file_path, 'r') do |f|
            f.each_line do |line|
                return line.split(",").map(&:strip)
            end
        end
    end


    def find_node(start)
        self.routeHash.each do |key, value|
            if key.name === start
                start = key
            end
        end
        return start
    end

    def numStops(start, final, maxStops)
        return findRoutes(start, final, 0, maxStops)
    end

    def findRoutes(start, final, depth, maxStops)
        start = self.find_node(start)
        routes = 0

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


    def exactStops(start, final, exactStops)
        return exactStopsRoutes(start, final, 0, exactStops)
    end

    def exactStopsRoutes(start, final, stops, exactStops)
        start = self.find_node(start)
        routes = 0

        stops = 0
        if stops > exactStops
            return routes
        else
            start.visited = true
            edge = self.routeHash[start]

            if edge
                if edge.destination.name === final && stops === exactStops
                    routes +=1
                    edge = edge.next
                    stops+=1

                elsif !edge.destination.visited
                    routes +=1
                    routes +=self.exactStopsRoutes(edge.destination.name, final, stops, exactStops)
                    stops -=1
                end
                edge = edge.next
            end
        end

        start.visited = false
        return routes
    end

    def shortestDistance(start, finish)
        return findShortestDistance(start, finish, 0, 0)
    end

    def findShortestDistance(start, finish, weight=0, shortestDistance=0)
        start = self.find_node(start)
        start.visited = true
        edge = self.routeHash[start]

        while edge
            if edge.destination.name === finish || !edge.destination.visited
                weight += edge.weight
                if edge.destination.name === finish
                    if shortestDistance === 0 || weight < shortestDistance
                        shortestDistance = weight
                        start.visited = false
                        return shortestDistance
                    end
                elsif !edge.destination.visited
                    shortestDistance = self.findShortestDistance(edge.destination.name, finish, weight, shortestDistance)
                    weight -=edge.weight
                end
            end
            edge = edge.next
        end

        start.visited = false
        return shortestDistance
    end

    def exactRoute(*args)
        stations = args
        routes = Hash.new

        self.graphList.each do |route|
            routes[route[0,2]] = route[2]
        end

        i = 0
        distance = 0
        while i < stations.length-1
            route = stations[i]+stations[i+1]
            if routes[route]
                distance += routes[route].to_i
                i+=1
            else
                puts "NO SUCH ROUTE"
                return
            end
        end
        puts distance
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

# g = make_graph()

# # MANUALLY ADDS THE NODES AND EDGES
g = Graph.new
g.graphList = g.createGraphList("input.txt")
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


#QUESTION 1: EXACT ROUTE
g.exactRoute("A", "B", "C")
#QUESTION 2: EXACT ROUTE
g.exactRoute("A", "D")
#QUESTION 3: EXACT ROUTE
g.exactRoute("A", "D", "C")
#QUESTION 4: EXACT ROUTE
g.exactRoute("A", "E", "B", "C", "D")
#QUESTION 5: EXACT ROUTE
g.exactRoute("A", "E", "D")
# QUESTION 6: # OF TRIPS STARTING AT X, ENDING AT Y WITH MAX STOPS
puts g.numStops("C", "C", 3)
# QUESTION 7: # OF TRIPS STARTING AT X, ENDING AT Y WITH EXACT STOPS
puts g.exactStops("A", "C", 4)
# QUESTION 8: SHORTEST DISTANCE BETWEEN X & Y
puts g.shortestDistance("A", "C")
# QUESTION 9: SHORTEST DISTANCE BETWEEN X & Y
puts g.shortestDistance("B", "B")
#QUESTION 10: ROUTES BETWEEN X AND Y WITHIN MAX DISTANCE
# g.routesWithin("C", "C", 30)
