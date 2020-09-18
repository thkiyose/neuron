class ContributionsController < ApplicationController
  def top
  end

  def home
    redirect_to top_contributions_path unless user_signed_in?
    @post = Post.new
    @contributions = Contribution.all
  end

end
