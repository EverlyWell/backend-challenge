class MembersController < ApplicationController
  before_action :set_member, only: [:show, :update, :destroy]

  # GET /members
  def index
    @members = Member.all

    render json: @members
  end

  # GET /members/1
  def show
    render json: @member
  end

  # POST /members
  def create
    begin 
      @member = Member.new(member_params)

      if @member.save
        render json: @member, status: :created, location: @member
      else
        render json: @member.errors, status: :unprocessable_entity
      end
    rescue ActionController::ParameterMissing
      render :nothing => true, :status => :bad_request
    end
  end

  # PATCH/PUT /members/1
  def update
    if @member.update(member_params)
      render json: @member
    else
      render json: @member.errors, status: :unprocessable_entity
    end
  end

  # DELETE /members/1
  def destroy
    @member.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      begin
        @member = Member.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render :nothing => true, :status => :bad_request
      end
    end

    # Only allow a list of trusted parameters through.
    def member_params
      params.fetch(:member, {})
      params.require(:member).permit(:first_name, :last_name, :url)
    end
end
