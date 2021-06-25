# frozen_string_literal: true

# Manages Members, you can use the following endpoints:
#   POST /members
#   GET /members
#   GET /members/:id
class MembersController < ApplicationController
  def index
    respond_to do |format|
      format.html { render :index, locals: { members: Member.ordered } }
      format.json { render json: Member.ordered }
    end
  end

  def show
    member = Member.find_by(id: params[:id])
    if member
      render json: member
    else
      render json: {}, status: :not_found
    end
  end

  def new
    render :new, locals: { member: Member.new(url: "http://www.example.com") }
  end

  def create
    member = Member.new(member_params)
    if member.save
      respond_to do |format|
        format.html { redirect_to members_path }
        format.json { render json: member, status: :ok }
      end
    else
      respond_to do |format|
        format.html { render :new, locals: { member: member } }
        format.json { render json: member, status: :unprocessable_entity }
      end
    end
  end

  private

  def member_params
    params.fetch(:member, {}).permit(:first_name, :last_name, :url)
  end
end
