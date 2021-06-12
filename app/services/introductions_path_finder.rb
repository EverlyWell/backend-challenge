require "immutable"

class IntroductionsPathFinder
  attr_reader :all_members, :adjacency_list, :current_member

  def initialize(current_member)
    @current_member = current_member

    # Avoid N+1 queries by loading ALL 
    # members with their friends in 3 queries (Member -> Friendships -> Member)
    @all_members = Member.all.includes(:friends).inject({}) do |hash, member|
      member.introduction_path = Immutable::Vector[]
      hash[member.id] = member
      hash
    end

    @adjacency_list = all_members.values.inject({}) do |graph, member|
      graph[member.id] = all_members[member.id].friends.map(&:id)
      graph
    end

    find_paths
  end

  def path_to(member)
    all_members[member.id].introduction_path
  end

  private

  # Implement a Breadth First Search
  def find_paths
    queue = Queue.new
    explored = Set.new
    queue.push current_member.id

    while !queue.empty?
      visiting_id = queue.pop
      visiting = all_members[visiting_id]
      explored.add visiting_id

      adjacency_list[visiting_id].each do |friend_id|
        unless explored.include? friend_id
          queue.push friend_id
          friend = all_members[friend_id]

          friend.introduction_path = visiting.introduction_path.add(friend)
        end
      end
    end
  end
end
