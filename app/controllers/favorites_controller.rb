class FavoritesController < ApplicationController
  before_action :authenticate_user!
  respond_to? :js

  def create
    @contribution = Contribution.find(params[:favorite][:contribution_id])
    favorite = current_user.favorites.create(contribution_id: @contribution.id)
    flash.now[:notice] = "投稿をお気に入りしました。"
  end

  def destroy
  end
end
