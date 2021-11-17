class FriendshipResource < JSONAPI::Resource
  attributes :member_id, :friend_id, :friend_full_name, :friend_profile_url
  
  def friend_full_name
    "#{@model.friend.first_name} #{@model.friend.last_name}"
  end

  def friend_profile_url
    @model.friend.url
  end
end