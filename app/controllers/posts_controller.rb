class PostsController < ApplicationController
  before_action :authenticate_user!

  def new
    @post = Post.new
    respond_to do |format|
      format.js { render :new }
    end
  end

  def create
    @user = current_user
    @contribution = @user.contributions.build
    @contributions = home_contributions(current_user).order(created_at: :desc)
    @post = @contribution.build_post(post_params)
    if @post.save
      redirect_to home_contributions_path, notice: I18n.t("activerecord.flash.post.create")
    else
      render home_contributions_path
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to root_path
      flash[:notice] = I18n.t("activerecord.flash.post.edit")
    else
      render :edit
    end
  end

  private
    def post_params
      params.require(:post).permit(:content)
    end

    def home_contributions(current_user)
      ids = current_user.following.ids << current_user.id
      Contribution.includes(:post, [user: [:profile, :favorites]]).where(user_id: ids)
    end
end
