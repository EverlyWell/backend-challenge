class MembersController < ApplicationController
  before_action :set_member, only: [:update, :destroy]

  # SHOW/INDEX/CREATE replaced by standardized jsonapi-resources gem actions:
  # https://github.com/cerebris/jsonapi-resources/blob/master/lib/jsonapi/acts_as_resource_controller.rb#L18

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
      @member = Member.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def member_params
      params.require(:member).permit(:first_name, :last_name, :url)
    end
end
