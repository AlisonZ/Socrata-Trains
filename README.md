# PROBLEM ONE: TRAINS

Problem: The local commuter railroad services a number of towns in Kiwiland. Because of monetary concerns, all of the tracks are 'one-way.' That is, a route from Kaitaia to Invercargill does not imply the existence of a route from Invercargill to Kaitaia. In fact, even if both of these routes do happen to exist, they are distinct and are not necessarily the same distance!

The purpose of this problem is to help the railroad provide its customers with information about the routes. In particular, you will compute the distance along a certain route, the number of different routes between two towns, and the shortest route between two towns.

Input: A directed graph where a node represents a town and an edge represents a route between two towns. The weighting of the edge represents the distance between the two towns. A given route will never appear more than once, and for a given route, the starting and ending town will not be the same town.

Output: For test input 1 through 5, if no such route exists, output 'NO SUCH ROUTE'. Otherwise, follow the route as given; do not make any extra stops! For example, the first problem means to start at city A, then travel directly to city B (a distance of 5), then directly to city C (a distance of 4).

1. The distance of the route A-B-C.
2. The distance of the route A-D.
3. The distance of the route A-D-C.
4. The distance of the route A-E-B-C-D.
5. The distance of the route A-E-D.
6. The number of trips starting at C and ending at C with a maximum of 3 stops. In the sample data below, there are two such trips: C-D-C (2stops). and C-E-B-C (3 stops).
7. The number of trips starting at A and ending at C with exactly 4 stops. In the sample data below, there are three such trips: A to C (via B,C,D); A to C (via D,C,D); and A to C (via D,E,B).
8. The length of the shortest route (in terms of distance to travel) from A to C.
9. The length of the shortest route (in terms of distance to travel) from B to B.
10. The number of different routes from C to C with a distance of less than 30. In the sample data, the trips are: CDC, CEBC, CEBCDC, CDCEBC, CDEBC, CEBCEBC, CEBCEBCEBC.

Test Input:

For the test input, the towns are named using the first few letters of the alphabet from A to E. A route between two towns (A to B) with a distance of 5 is represented as AB5.

Graph: AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7


Expected Output:

Output #1: 9
Output #2: 5
Output #3: 13
Output #4: 22
Output #5: NO SUCH ROUTE
Output #6: 2
Output #7: 3
Output #8: 9
Output #9: 9
Output #10: 7

# REQUIRED INSTALLATIONS
## Ruby
This program uses Ruby v. 2.4.0. If Ruby is not on your machine, complete the following steps, which use the Ruby Version Manager(RVM) for installation. If you have Ruby on your machine and need to update the version without RVM, look to the [Ruby docs](https://www.ruby-lang.org/en/documentation/installation/)

### Ruby Version Manager
* Install from the terminal with $ \curl -sSL https://get.rvm.io | bash -s stable
* Verify that installation was successful with $ rvm -v

### Ruby Install
* Install ruby from terminal $ rvm install 2.4.0

### Set-up Testing
Testing for this program uses Minitest and Rake
* Minitest: From the terminal run  $ gem install minitest -v 5.8.4
* Rake: $ gem install rake


# HOW TO RUN THE CODE
### Clone and Run Repo
1. From terminal cd to folder to clone project
* $ git clone https://github.com/AlisonZ/Socrata-Trains.git

2. cd into folder
* $ cd Socrate-Trains
3. Run file
* $ ruby lib/run-program.rb

# HOW TO RUN TESTS
After installing Minitest and Rake, from terminal cd to project folder
* run $rake

# HOW TO RUN NEW SEARCHES
* This program comes preset with the inputs in problem set and uses the routes and weights provided in Graph input(line 26 of this README)
* Graph input is stored in lib/input.txt

## RUNNING PROGRAM WITH EXISTING GRAPH
* To run program with alternate starting and destination nodes with stop and distance information, the methods in run-program.rb can be adjusted
* The starting and destination nodes(stations) passed into these functions must be pre-existing in the graph created from the Graph input
* Following is an overview of the methods, their functionality and how to adjust them with the current graph data

1. exactRoute(args)
    * see lines 22-31 of run-program.rb
    * Goal: finds the distance of a specific route, i.e. the distance from A->E->D
    * Arguments: takes an indeterminate number of arguments(stations), each entered as a String
    * Adjustment: in run-program.rb call the method exactRoute on the graph created, pass in the stations of the route as individual string arguments

2. numStops(start, final, maxStops)
* see lines 32-33 of run-program.rb
* Goal: Find the number of possible routes from start station to final station that don't have more stops than maxStops
* Adjustment: in run-program.rb call the method numStops on the graph created, pass in the start and final stations as individual string arguments and the max number of stops

3. exactStops(start, final, exactStops)
* see lines 34-34 of run-program.rb
* Goal: Find the number of possible routes from start station to final with exactly # of stops
* Adjustment: in run-program.rb call the method exactRoute on the graph created, pass in the start and final stations as individual string arguments and the number of stops

4. shortestDistance(start, final)
* see lines 37-38 of run-program.rb
* Goal: find the shortest distance (measured by weight between stations) from start to final node
* Adjustment: in run-program.rb call the method shortestDistance on the graph created, pass in start and final stations as individual strings

5. routesWithin(start, final, maxDistance)
* see lines 40-41 of run-program.rb
* Goal: find how many possible routes from start to finish that have a distance(weight) equal to or less than the maxDistance
* Adjustment: in run-program.rb call the method routesWithin on the graph created, pass in start, final and maximum distance
