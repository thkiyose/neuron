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
    @contribution = Contribution.find(params[:id])
    @contribution.destroy
    respond_to do |format|
      format.js { render :destroy }
    end
  end

  private
  def home_contributions(current_user)
    ids = current_user.following.ids << current_user.id
    Contribution.includes(:post, [user: [:profile, :favorites]]).where(user_id: ids)
  end
end
