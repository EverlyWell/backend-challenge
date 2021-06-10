class FriendshipsController < ApplicationController
  def create
    @member = Member.find friendship_params[:member_id]
    @new_friend = Member.find friendship_params[:friend_id]
    @member.follow @new_friend

    respond_to do |format|
      format.json { head :ok }
      format.html { redirect_to member_path(@member) }
    end
  end

  def destroy
    friendship = Friendship.find(params[:id])
    member = friendship.member
    friend = friendship.friend
    member.unfollow friend
    redirect_to member_path(member)
  end

  private

  def friendship_params
    params.require(:friendship).permit(:member_id, :friend_id)
  end
end
