class ContributionsController < ApplicationController
  def top
  end

  def home
    unless user_signed_in?
      redirect_to top_contributions_path
    else
      @post = Post.new
      @contributions = Contribution.all.includes(:post, [user: [:profile, :favorites]]).self_contributions(current_user.id).order(created_at: :desc)
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

end
