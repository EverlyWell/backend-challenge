class FriendshipResource < JSONAPI::Resource
  attributes :member_id, :friend_id

  attributes :friend_full_name
  
  def friend_full_name
    "#{@model.friend.first_name} #{@model.friend.last_name}"
  end
end