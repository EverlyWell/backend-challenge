# The purpose of this class is to represent the relationships between friends in a graph
# so we can query it about those relationships and build connections
class MembersSocialGraph
  def initialize
    @members = Member.all
  end

  def find_path_between_members(from:, to:)
    graph = build_graph

    breadth_first_search(graph, from, to)
  end

  private

  def reconstruct_path(tail, nodes_path)
    path = []

    # Go backwards from the tail into the origin
    while tail.present?
      path << tail

      tail = nodes_path[tail]
    end

    # We need to reverse because we've been gathering our nodes from the tail to the head
    path.reverse
  end

  # A method that returns an array representing path,if any, from one node to the other
  # or an empty array if the nodes are unconnected on the graph
  def breadth_first_search(graph, origin_member, target_member)
    # We will fill a queue with all the nodes to progressively move up to the graph tree
    queue = []
    queue << origin_member

    # This hash will allow us to track the path from the origin to the target
    nodes_path = {origin_member => nil}

    while queue.any?
      node = queue.shift

      # We found the target node let's try to find the shortest path
      if node == target_member
        return reconstruct_path(target_member, nodes_path)
      end

      # Add to our queue of nodes
      graph[node].each do |neighbor|
        # Skip if we already visited that node
        if !nodes_path.has_key?(neighbor)
          nodes_path[neighbor] = node

          queue.push(neighbor)
        end
      end
    end
    # if we never find a path between two members return an empty array
    []
  end

  def build_graph
    graph = {}

    @members.each do |member|
      graph[member] = member.friends
    end

    graph
  end
end
