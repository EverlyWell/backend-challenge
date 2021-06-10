class MembersController < ApplicationController
  def new
    @member = Member.new
  end

  def show
    @member = Member.find params[:id]
    @members = Member.all.includes(:friends)
    @can_follow = @members.select { |m| m.can_follow? @member }
    @following = @members.select { |m| m.friends.include? @member }

    respond_to do |format|
      format.json { render json: @member.to_json }
      format.html
    end
  end

  def index
    @members = Member.all.order(name: :asc)

    respond_to do |format|
      format.json { render json: @members.to_json }
      format.html
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
