class ContributionsController < ApplicationController
  def top
  end

  def home
    redirect_to top_contributions_path unless user_signed_in?
    @post = Post.new
    @contributions = Contribution.all.includes(:user,:post).home_contributions(current_user.id)
  end

  def news
    @contributions = Contribution.all
  end

end
