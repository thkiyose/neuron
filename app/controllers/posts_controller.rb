class PostsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = current_user
    contribution = @user.contributions.build
    post = contribution.build_post(post_params)
    respond_to do |format|
      if post.save
        @msg = "postを投稿しました。"
        format.js { render :create }
      else
        format.js { render :create }
      end
    end
  end

  private
    def post_params
      params.require(:post).permit(:content)
    end

end
