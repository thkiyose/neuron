class UserRelationsController < ApplicationController
  before_action :authenticate_user!
  respond_to? :js, only: %i(create destroy)

  def show_following
    @user = User.find(params[:id])
  end

  def show_followers
    @user = User.find(params[:id])
  end

  def create
    @user = User.find(params[:user_relation][:followed_id])
    current_user.follow!(@user)
  end

  def destroy
    @user = UserRelation.find(params[:id]).followed
    current_user.unfollow!(@user)
  end
end
