class ApplicationController < ActionController::Base
  before_action :set_search
  protect_from_forgery with: :exception

  def set_search
    @search = Contribution.ransack(params[:q])
    @searched_contributions = @search.result.includes(:post,:favorites,:comments,:user,[que: [options: :votes]]).order(created_at: :desc)
    params[:q].present? ? @title = "キーワード\"#{params[:q][:post_content_or_que_question_cont]}\"の検索結果を表示しています" : @title = "新着投稿を表示しています"
  end
end
