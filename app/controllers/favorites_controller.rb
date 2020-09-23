class FavoritesController < ApplicationController
  before_action :authenticate_user!
  respond_to? :js

  def create
    @contribution = Contribution.find(params[:favorite][:contribution_id])
    flash[:notice] = "投稿をお気に入りしました。"
    favorite = current_user.favorites.create(contribution_id: @contribution.id)
  end

  def destroy
    favorite = current_user.favorites.find_by(id: params[:id])
    @contribution = Contribution.find(favorite.contribution_id)
    favorite.destroy
  end
end
