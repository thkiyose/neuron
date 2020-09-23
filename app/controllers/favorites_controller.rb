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

  def show_favorites
    @favorite_contributions = User.find(params[:id]).favorite_contributions
  end

  def show_favorited_by
    @favorite_users = Contribution.find(params[:id]).favorite_users
  end
end
