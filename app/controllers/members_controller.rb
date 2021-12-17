class MembersController < ApplicationController
  def show
    @member = Member.find(permitted_params[:id])
  end

  def index
    @members = Member.all
  end

  private

  def permitted_params
    params.permit(:id)
  end
end
