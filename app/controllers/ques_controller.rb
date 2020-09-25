class QuesController < ApplicationController
  before_action :authenticate_user!
  respond_to? :js

  def new
    @que = Que.new
  end
end
