class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [:show, :update, :destroy]

  # GET /friendships
  def index
    @friendships = Friendship.all

    render json: @friendships
  end

  # GET /friendships/1
  def show
    render json: @friendship
  end

  # POST /friendships
  def create
    begin 
      @friendship = Friendship.new(friendship_params)
      if @friendship.save
        render json: @friendship, status: :created, location: @friendship
      else
        render json: @friendship.errors, status: :unprocessable_entity
      end
    rescue ActionController::ParameterMissing
      render :nothing => true, :status => :bad_request
    end
  end

  # PATCH/PUT /friendships/1
  def update
    if @friendship.update(friendship_params)
      render json: @friendship
    else
      render json: @friendship.errors, status: :unprocessable_entity
    end
  end

  # DELETE /friendships/1
  def destroy
    @friendship.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friendship
      @friendship = Friendship.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friendship_params
      params.require(:friendship).permit(:member_id, :friend_id)
    end
end
