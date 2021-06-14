class FriendshipsController < ApplicationController
  layout "friendships"

  def create
    member = Member.find friendship_params[:member_id]
    new_friend = Member.find friendship_params[:friend_id]
    member.follow new_friend
    can_follow = member.non_followers.order(name: :asc)

    render partial: 'friendships/friendships', locals: { member: member, can_follow: can_follow }
  end

  def destroy
    begin
      friendship = Friendship.find(params[:id])
      member = friendship.member
      friend = friendship.friend
      member.unfollow friend
    rescue ActiveRecord::RecordNotFound
      member = Member.find params[:member_id]
    end

    can_follow = member.non_followers.order(name: :asc)

    render partial: 'friendships/friendships', locals: { member: member, can_follow: can_follow }
  end

  private

  def friendship_params
    params.require(:friendship).permit(:member_id, :friend_id)
  end
end
