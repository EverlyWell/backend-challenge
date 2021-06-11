class IntroductionsPathFinder
  def initialize(current_member)
    @current_member = current_member
  end

  def all_members
    # Avoid N+1 queries by loading ALL 
    # members with their friends in 3 queries (Member -> Friendships -> Member)
    @all_members ||= Member.all.includes(:friends).inject({}) do |hash, member|
      hash[member.id] = member
      hash
    end
  end

  def adjacency_list
    @adjacency_list ||= all_members.values.inject({}) do |graph, member|
      graph[member.id] = all_members[member.id].friends.map(&:id)
      graph
    end
  end

  # Implement a Breadth First Search
  def find_paths
    queue = Queue.new
    explored = Set.new
    queue.push @current_member.id

    while !queue.empty?
      visiting = queue.pop
      explored.add visiting

      adjacency_list[visiting].each do |friend_id|
        unless explored.include? friend_id
          queue.push friend_id
          all_members[friend_id].parent = all_members[visiting]
        end
      end
    end
  end

  def path_to(member)
    path = []
    current_member = all_members[member.id]

    while current_member.parent.present?
      path.push current_member
      parent = all_members[current_member.parent.id]
      current_member = parent
    end

    path.reverse
  end
end
