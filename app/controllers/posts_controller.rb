class PostsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = current_user
    contribution = user.contributions.build
    post = contribution.build_post(post_params)
    post.save
    redirect_to root_path
  end

  private
    def post_params
      params.require(:post).permit(:content)
    end

end
