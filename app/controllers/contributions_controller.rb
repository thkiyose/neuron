class ContributionsController < ApplicationController
  def top
  end

  def home
    unless user_signed_in?
      redirect_to top_contributions_path
    else
      @post = Post.new
      @contributions = Contribution.all.includes(:user,:post).home_contributions(current_user.id)
    end
  end

  def news
    @contributions = Contribution.all.includes(:user,:post)
  end

end
