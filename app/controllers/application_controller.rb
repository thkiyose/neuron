class ApplicationController < ActionController::Base
  before_action :set_search
  protect_from_forgery with: :exception

  def set_search
    @search = Contribution.includes(:post, [user: [:profile, :favorites]]).ransack(params[:q])
    @searched_contributions = @search.result(distinct: true).order(created_at: :desc)
    if params[:q].present?
      @title = "キーワード\"#{params[:q][:post_content_cont]}\"の検索結果を表示しています"
    else
      @title = "新着投稿を表示しています"
    end
  end
end
