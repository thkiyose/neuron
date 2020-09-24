class ContributionsController < ApplicationController
  def top
  end

  def home
    unless user_signed_in?
      redirect_to top_contributions_path
    else
      @post = Post.new
      @contributions = home_contributions(current_user).order(created_at: :desc)
    end
  end

  def news
  end

  def destroy
    authenticate_user!
    @contribution = Contribution.find(params[:id])
    @contribution.destroy
    redirect_to root_path, notice: "投稿を削除しました。"
  end

  private
  def home_contributions(current_user)
    ids = current_user.following.ids << current_user.id
    Contribution.includes(:post, [user: [:profile, :favorites]]).where(user_id: ids)
  end
end
