class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    user = current_user
    contribution = user.build_contribution
    post = contribution.build_post
    if post.save
      redirect_to root_path
    else
      render "contributions/index"
  end
end
