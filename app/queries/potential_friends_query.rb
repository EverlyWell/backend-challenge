# This class' responsability is to take any member and some word and find other members 
# that are not already friends with but that have similar headings to the query
#
# Usage:
# PotentialFriendsQuery.new(target_member, word_to_search_headings).get_potential_friends
# => [Member]
# 
# The member on the array will have the attribute path_to_other_member set
# this path will be an array of members that connect some @member friend to others
class PotentialFriendsQuery
  def initialize(member, query)
    @member = member
    @query = query
  end

  def get_potential_friends
    members = members_with_headings(@query)
    members = remove_friends(members)
    members = connected_members(members)

    members
  end

  private

  def connected_members(members)
    connected = []

    members.each do |potential_friend|
      path = MembersSocialGraph.new.find_path_between_members(from: @member, to: potential_friend)

      if path.any?
        # Save the result here for later use on the potential_friends search
        potential_friend.path_to_other_member = path

        connected << potential_friend
      end
    end

    connected
  end

  def remove_friends(members)
    members -= [@member.friends] # We just want potential not already friends with member
  end

  def members_with_headings(query)
    normal_query = normalize_query(query)

    is_substring = Heading.where("headings.name LIKE ?", "%#{normal_query}%")

    # Provided by the fuzzystrmatch with can search using the levenshtein distance algorithm
    looks_similar = Heading.where("levenshtein(headings.name, ?) < 2", "%#{normal_query}%")

    # Provided by the fuzzystrmatch with can search using the soundex algorithm
    sounds_similar = Heading.where("soundex(headings.name) = soundex(?)", "%#{normal_query}%")

    headings = is_substring.or(looks_similar).or(sounds_similar)

    headings.map(&:member)
  end

  def normalize_query(query)
    query.strip!
    unaccented = I18n.transliterate(query)
    unaccented.downcase
  end
end
