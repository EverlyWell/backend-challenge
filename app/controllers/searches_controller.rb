class SearchesController < ApplicationController
  layout "searches"

  def show
    @member = Member.find params[:member_id]
    @topic = search_params[:topic]
    @search_results = @member.search_in_non_followers(@topic)
    @finder = IntroductionsPathFinder.new(@member)
    @finder.find_paths
  end

  private

  def search_params
    params.require(:search).permit(:topic)
  end
end
