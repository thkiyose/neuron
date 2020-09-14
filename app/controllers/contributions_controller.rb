class ContributionsController < ApplicationController
  before_action :authenticate_user!, only: %i(index)
  def top
  end

  def index
  end
end
