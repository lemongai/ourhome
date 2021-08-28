class HomesController < ApplicationController
  before_action :require_user_logged_in, only: [:index]

  def index
    @post = current_user.posts.build

    @pagy, @posts = pagy(current_user.feed_posts.order(id: :desc))
    @notices = Notice.all.order(id: :desc).limit(5)
  end
end
