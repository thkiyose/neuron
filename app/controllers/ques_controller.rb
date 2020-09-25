class QuesController < ApplicationController
  before_action :authenticate_user!
  respond_to? :js

  def new
    @que = Que.new
    4.times do
      @que.options.build
    end
  end

  def create
    @user = current_user
    @contribution = @user.contributions.build
    @contributions = home_contributions(current_user).order(created_at: :desc)
    @que = @contribution.build_que(que_params)
    unless @que.save
      render :new
    end
  end

  private
    def que_params
      params.require(:que).permit(
        :question,
        :que_type,
        options_attributes: [:id,
                             :option_name,
                             :_destroy]
      )
    end

    def home_contributions(current_user)
      ids = current_user.following.ids << current_user.id
      Contribution.includes(:post, [que: :options], [user: [:profile, :favorites, :comments]]).where(user_id: ids)
    end
end
