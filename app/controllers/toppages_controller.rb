class ToppagesController < ApplicationController
  def index
    if logged_in?
      redirect_to  controller: :homes, action: :index
    end
  end
end
