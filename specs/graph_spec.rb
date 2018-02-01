require_relative 'spec_helper'
require_relative '../lib/run-program.rb'

describe "Node class" do
    before do
        @my_node = Node.new("Z")
    end

    it "creates a node" do
        @my_node.must_be_instance_of Node
    end
    it "node initializes with a name" do
        @my_node.name.must_equal "Z"

    end
    it "initializes node with visited property set to false" do
        @my_node.visited.must_equal false
    end
    it "visited property can be set to true" do
        @my_node.visited = true
        @my_node.visited.must_equal true
    end
end

describe "Edge class" do
    before do
        @my_edge = Edge.new("A", "Z", 16)
    end

    it "creates an edge" do
        @my_edge.must_be_instance_of Edge
    end
    it "initializes edge with origin, destination, weight and next" do
        @my_edge.origin.must_equal "A"
        @my_edge.destination.must_equal "Z"
        @my_edge.weight.must_equal 16
        @my_edge.next.wont_be_nil
    end
    it "add_next takes an edge as next" do
        new_edge = Edge.new("R", "D", 15)
        @my_edge.add_next(new_edge).must_be_instance_of Edge

    end
    it "is able to chain edges through next" do
        new_edge = Edge.new("R", "D", 15)
        another_edge = Edge.new("D", "Z", 32)
        @my_edge.add_next(new_edge)
        @my_edge.next.add_next(another_edge)
        @my_edge.next.next.origin.must_equal "D"
    end
end


describe "Graph class" do
    before do
        @my_graph = Graph.new
        @A = Node.new("A")
        @B = Node.new("B")
        @C = Node.new("C")
        @D = Node.new("D")
        @E = Node.new("E")


        @my_graph.routeHash[A] = Edge.new(A, B, 5)
        @my_graph.routeHash[A].add_next(Edge.new(A, D, 5))
        @my_graph.routeHash[A].next.add_next(Edge.new(A, E, 7))
        @my_graph.routeHash[B] = Edge.new(B, C, 4)
        @my_graph.routeHash[C] = Edge.new(C, D, 8)
        @my_graph.routeHash[C].add_next(Edge.new(C, E, 2))
        @my_graph.routeHash[D] = Edge.new(D, C, 8)
        @my_graph.routeHash[D].add_next(Edge.new(D, E, 6))
        @my_graph.routeHash[E] = Edge.new(E, B, 3)

        @my_graph.graphList = @my_graph.createGraphList("./lib/input.txt")

    end

    it "creates a graph" do
        @my_graph.must_be_instance_of Graph
    end

    describe "exactRoute" do
        it "takes an exact route and finds the distance" do
            output1 = @my_graph.exactRoute("A", "B", "C")
            output1.must_equal 9

            output2 = @my_graph.exactRoute("A", "D")
            output2.must_equal 5

            output3 = @my_graph.exactRoute("A", "D", "C")
            output3.must_equal 13

            output4 = @my_graph.exactRoute("A", "E", "B", "C", "D")
            output4.must_equal 22
        end
        it "prints out NO SUCH ROUTE if there is no route that matches input" do
            output = @my_graph.exactRoute("A", "E", "D")
            output.must_equal "NO SUCH ROUTE"

        end
        it "finds the exact route of lowercase input" do
            output = @my_graph.exactRoute("a", "b", "c")
            output.must_equal 9
        end

    end

    describe "numStops" do
        it "takes start and finish stops and finds number of routes with max stops" do
            routes = @my_graph.numStops("C", "C", 3)
            routes.must_equal 2
        end
        it "prints out NO SUCH ROUTES if invalid input" do
            routes = @my_graph.numStops("E", "Z", 1)
            routes.must_equal "NO SUCH ROUTE"

        end
        it "finds routes with lowercase input" do
            routes = @my_graph.numStops("c", "c", 3)
            routes.must_equal 2
        end
    end

    describe "exactStops" do
        it "takes start and finish stops and finds number of routes with exact number of stops" do
            routes = @my_graph.exactStops("A", "C", 4)
            routes.must_equal 3
        end
        it "finds routes with lowercase input" do
            routes = @my_graph.exactStops("a", "c", 4)
            routes.must_equal 3
        end
        it "returns NO SUCH ROUTES with invalid input" do
            routes = @my_graph.exactStops("A", "Z", 4)
            routes.must_equal "NO SUCH ROUTE"
        end
    end

    describe "shortestDistance" do
        it "takes a start and finish and find shortest route" do
            distance = @my_graph.shortestDistance("A", "C")
            distance.must_equal 9
        end
        it "finds distance with lowercase input" do
            distance = @my_graph.shortestDistance("a", "C")
            distance.must_equal 9
        end
        it "returns NO SUCH INPUT with invalid input" do
            distance = @my_graph.shortestDistance("A","Z")
            distance.must_equal "NO SUCH ROUTE"
        end
    end

    xdescribe "routesWithin" do
        it "takes a start and stop with max distance and returns number of routes" do
            routes = @my_graph.routesWithin("C", "C", 30)
            routes.must_equal 7
        end
        it "finds routes with lowercase input" do
            routes = @my_graph.routesWithin("c", "c", 30)
            routes.must_equal 7
        end
        it "returns NO SUCH ROUTE with invalid input" do
            routes = @my_graph.routesWithin("A", "Z", 16)
            routes.must_equal "NO SUCH ROUTE"
        end
    end

end
