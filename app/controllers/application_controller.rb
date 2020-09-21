class ApplicationController < ActionController::Base
  before_action :set_search
  protect_from_forgery with: :exception

  def set_search
    @search = Contribution.includes(:post,user: :profile).ransack(params[:q])
    @searched_contributions = @search.result(distinct: true).order(created_at: :desc)
  end
end
