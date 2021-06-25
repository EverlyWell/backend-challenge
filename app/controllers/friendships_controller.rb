# frozen_string_literal: true

class FriendshipsController < ApplicationController
  def create
    friendship = Friendship.new(friendship_params)
    if friendship.save
      render json: friendship, status: :ok
    else
      render json: friendship, status: :unprocessable_entity
    end
  end

  private

  def friendship_params
    params.fetch(:friendship, {}).permit(:member_id, :friend_id)
  end
end
