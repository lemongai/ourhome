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

def require_admin
    unless current_user.admin == true
      redirect_to root_path
    end
end


  def counts(user)
    @count_posts = user.posts.count
    @count_likes = user.favorites.count
    @count_notices = user.notices.count
  end
end
