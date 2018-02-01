require './lib/graph.rb'

g = Graph.new
g.graphList = g.createGraphList("./lib/input.txt")
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


#
#QUESTION 1: EXACT ROUTE
 puts "Output #1: #{g.exactRoute("A", "B", "C")}"
#QUESTION 2: EXACT ROUTE
 puts "Output #2: #{g.exactRoute("A", "D")}"
#QUESTION 3: EXACT ROUTE
 puts "Output #3: #{g.exactRoute("A", "D", "C")}"
#QUESTION 4: EXACT ROUTE
 puts "Output #4: #{g.exactRoute("A", "E", "B", "C", "D")}"
#QUESTION 5: EXACT ROUTE
puts "Output #5: #{g.exactRoute("A", "E", "D")}"
# QUESTION 6: # OF TRIPS STARTING AT X, ENDING AT Y WITH MAX STOPS
 puts "Output #6: #{g.numStops("C", "C", 3)}"
# QUESTION 7: # OF TRIPS STARTING AT X, ENDING AT Y WITH EXACT STOPS
 puts "Output #7: #{g.exactStops("A", "C", 4)}"
# QUESTION 8: SHORTEST DISTANCE BETWEEN X & Y
puts "Output #8: #{g.shortestDistance("A", "C")}"
# QUESTION 9: SHORTEST DISTANCE BETWEEN X & Y
 puts "Output #9: #{g.shortestDistance("B", "B")}"
#QUESTION 10: ROUTES BETWEEN X AND Y WITHIN MAX DISTANCE
# puts "Output #10: #{g.routesWithin("C", "C", 30)}"
