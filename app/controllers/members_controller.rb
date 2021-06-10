class MembersController < ApplicationController
  def new
    @member = Member.new
  end

  def show
    @member = Member.find params[:id]
    @members = Member.all.includes(:friends)
    @can_follow = @members.select { |m| m.can_follow? @member }
    @following = @members.select { |m| m.friends.include? @member }
  end

  def index
    @members = Member.all
  end

  def create
    @member = Member.new member_params
    if @member.save
      redirect_to @member
    end
  end

  private

  def member_params
    params.require(:member).permit(:name, :url)
  end
end
