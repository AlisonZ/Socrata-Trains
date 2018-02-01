require_relative 'spec_helper'
require_relative '../lib/graph.rb'

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
        # create nodes
        # create edges
        # create graph from nodes & edges
        # create graphList for the exactRoute function
    end
    it "creates a graph" do
        my_graph = Graph.new
        my_graph.class.must_equal Graph
    end
end
