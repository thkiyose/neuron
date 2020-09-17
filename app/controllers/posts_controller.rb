class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    user = current_user
    user.build_contribution
    if post.save
      redirect_to root_path
    else
      render "contributions/index"
    enddocke
  end
end
