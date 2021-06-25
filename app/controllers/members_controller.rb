# frozen_string_literal: true

# Manages Members, you can use the following endpoints:
#   POST /members
#   GET /members
#   GET /members/:id
class MembersController < ApplicationController
  def index
    render json: Member.ordered
  end

  def show
    member = Member.find_by(id: params[:id])
    if member
      render json: member
    else
      render json: {}, status: :not_found
    end
  end

  def create
    member = Member.new(member_params)
    if member.save
      render json: member, status: :ok
    else
      render json: member, status: :unprocessable_entity
    end
  end

  private

  def member_params
    params.fetch(:member, {}).permit(:first_name, :last_name, :url)
  end
end
