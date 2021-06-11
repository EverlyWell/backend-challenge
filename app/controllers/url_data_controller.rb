class UrlDataController < ApplicationController
  layout "searches"

  def show
    @member = Member.find params[:member_id]

    render json: {
      state: @member.state,
      html: render_to_string(partial: 'members/url_processing', locals: { member: @member })
    }
  end
end
