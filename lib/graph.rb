require './lib/edge.rb'
require './lib/node.rb'

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

    def exactRoute(*args)
        stations = args
        routes = Hash.new

        self.graphList.each do |route|
            routes[route[0,2]] = route[2]
        end

        i = 0
        distance = 0
        while i < stations.length-1
            route = stations[i].upcase+stations[i+1].upcase
            if routes[route]
                distance += routes[route].to_i
                i+=1
            else
                return "NO SUCH ROUTE"
            end
        end

        return distance
    end

    def numStops(start, final, maxStops)
        return findRoutes(start.upcase, final.upcase, 0, maxStops)
    end

    def findRoutes(start, final, depth, maxStops)
        start = self.find_node(start)
        destination = self.find_node(final)
        # TODO:ideally this would check if a Node, but hit a Ruby snag
        if start.class != String && destination.class != String
            depth +=1
            routes = 0
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
        else
            return "NO SUCH ROUTE"
        end
    end


    def exactStops(start, final, exactStops)
        return exactStopsRoutes(start.upcase, final.upcase, 0, exactStops)
    end

    def exactStopsRoutes(start, final, stops, exactStops)
        start = self.find_node(start)
        destination = self.find_node(final)
        routes = 0
        stops = 0

        if start.class != String && destination.class != String
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
        else
            return "NO SUCH ROUTE"
        end
    end

    def shortestDistance(start, finish)
        return findShortestDistance(start.upcase, finish.upcase, 0, 0)
    end

    def findShortestDistance(start, finish, weight=0, shortestDistance=0)
        start = self.find_node(start)
        destination = self.find_node(finish)

        if start.class != String && destination.class != String
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
        else
            return "NO SUCH ROUTE"
        end
    end
end
