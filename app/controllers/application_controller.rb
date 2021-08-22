class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger
  include SessionsHelper
  include Pagy::Backend

  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
end
