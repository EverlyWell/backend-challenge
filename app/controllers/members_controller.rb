class MembersController < ApplicationController
  def new
    @member = Member.new
  end

  def show
    @member = Member.find params[:id]
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
