class Edge
    attr_accessor :origin, :destination, :weight, :next

    def initialize(origin, destination, weight)
        @origin = origin
        @destination = destination
        @weight = weight
        @next = true
    end

    # TODO: remove this function if it does not end up being used recursively
    # can do the same thing now as just updating the .next feature of the edge currently on
    def add_next(edge)
        self.next = edge
        return edge
    end
end
