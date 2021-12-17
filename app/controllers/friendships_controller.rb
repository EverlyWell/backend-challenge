class FriendshipsController < ApplicationController
  before_action :authenticate_member!

  def create
    Friendship.create!(permitted_params)

    flash[:success] = 'Friendship created!'

    redirect_back(fallback_location: '/')
  end

  private

    def permitted_params
      params.require(:friendship).permit(:member_id, :friend_id)
    end
end
