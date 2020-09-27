class ProfilesController < ApplicationController
  before_action :set_profile, only: %i(show edit update)

  def show
  end

  def edit
      redirect_to profile_path(@profile.user.id) unless user_signed_in? && current_user.id == @profile.user.id
  end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path, notice: I18n.t("activerecord.flash.profile.update")
    else
      render :edit
    end
  end

  private
    def set_profile
      @profile = Profile.find(params[:id])
    end

    def profile_params
      params.require(:profile).permit(:screen_name,:introduction)
    end
end
