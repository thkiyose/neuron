class PostsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = current_user
    @contribution = @user.contributions.build
    @post = @contribution.build_post(post_params)
    respond_to do |format|
      if @post.save
        format.js { render :index }
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to root_path
      flash[:notice] = "postを編集しました。"
    else
      render :edit
    end
  end

  private
    def post_params
      params.require(:post).permit(:content)
    end

end
