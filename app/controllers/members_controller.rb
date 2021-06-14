class MembersController < ApplicationController
  def show
    @member = Member.find params[:id]
    @can_follow = @member.non_followers.processed

    respond_to do |format|
      format.html
      format.json { render json: @member.to_json }
    end
  end

  def index
    @members = Member.processed

    respond_to do |format|
      format.html
      format.json { render json: @members.to_json }
    end
  end

  def create
    member = Member.new member_params
    if member.save
      redirect_to member_path(member)
    end
  end

  private

  def member_params
    params.require(:member).permit(:name, :url)
  end
end
