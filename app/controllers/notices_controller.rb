class NoticesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  before_action :require_admin, only: [:new, :edit, :destroy, :create, :update]

  def index
    @pagy, @notices = pagy(Notice.all.order(id: :desc))
  end

  def new
    @pagy, @notices = pagy(Notice.all.order(id: :desc))
    @notice = Notice.new
  end

  def create
    @notice = current_user.notices.build(notice_params)
    if @notice.save
      flash[:success] = 'お知らせを投稿しました。'
      redirect_to notices_path
    else
      @pagy, @notices = pagy(current_user.notices.order(id: :desc))
      flash[:danger] = 'お知らせの投稿に失敗しました。'
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @notices = Notice.where(id: params[:id])
#    @pagy, @notices = pagy(Notice.all.order(id: :desc))
    @notice = Notice.find(params[:id])
  end

  def update
    @notice = Notice.find(params[:id])

    if @notice.update(notice_params)
      flash[:success] = 'お知らせは正常に更新されました'
      redirect_back(fallback_location: root_path)
#      redirect_to notices_path
    else
      @pagy, @notices = pagy(current_user.notices.order(id: :desc))
      flash.now[:danger] = 'お知らせは更新されませんでした'
      render 'notices/index'
    end
  end

  def destroy
    @notice.destroy
    flash[:success] = 'お知らせを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def notice_params
    params.require(:notice).permit(:content)
  end

  def correct_user
    @notice = current_user.notices.find_by(id: params[:id])
    unless @notice
      redirect_to root_url
    end
  end
end
