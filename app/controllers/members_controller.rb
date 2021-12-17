class MembersController < ApplicationController
  before_action :authenticate_member!

  def show
    @member = Member.find(member_permitted_params[:id])

    if searching_potential_friends?
      @potential_friends = search_potential_friends(@member)
    end
  end

  def index
    @members = Member.all
  end

  private

  def member_permitted_params
    params.permit(:id)
  end

  def search_permitted_params
    params.permit(:query)
  end

  def searching_potential_friends?
    search_permitted_params.present?
  end

  def search_potential_friends(member)
    query = search_permitted_params[:query]

    PotentialFriendsQuery.new(member, query).get_potential_friends
  end
end
