class MembersController < BaseController
  def index
    @members = Member.order(:first_name)
    render json: MemberSerializer.new(@members)
  end

  def show
    @member = Member.find(params[:id])
    render json: MemberSerializer.new(@member)
  end

  def create
    @member = Member.new(member_params)

    if @member.save
      ShortUrlJob.perform_later(@member.id)
      render json: MemberSerializer.new(@member)
    else
      render json: @member.errors, status: :unprocessable_entity
    end
  end

  private

  def member_params
    params.require(:member).permit(:first_name, :last_name, :url)
  end
end
