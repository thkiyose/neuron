class ApplicationController < ActionController::Base
  before_action :set_search
  protect_from_forgery with: :exception

  def set_search
    @search = Contribution.ransack(params[:q])
    @searched_contributions = @search.result(distinct: true)
  end
end
