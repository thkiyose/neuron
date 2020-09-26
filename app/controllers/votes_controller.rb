class VotesController < ApplicationController
  before_action :authenticate_user!
  respond_to? :js

  def create
    @contribution = Contribution.find(params[:contribution_id])
    current_user.votes.create(option_id: params[:option_id])
  end
end
