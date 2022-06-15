class Public::UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]
  before_action :no_user_show_when_user_deleted, only: :show

  def index
    @users = User.with_attached_account_image.where(is_deleted: false)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.includes_all.page(params[:page]).per(30)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      sleep(3)
      redirect_to user_path(@user)
      flash[:success] = "ユーザー情報を更新しました"
    else
      render :edit
    end
  end

  def likes
    @user = User.find(params[:id])
    likes = Like.where("user_id = ?", @user.id).pluck(:post_id)
    @like_posts = Post.includes_all.find(likes)
  end

  private

  # user_paramsはapplication_controllerにあり
  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user.same?(current_user)
      redirect_to user_path(@user)
      flash[:danger] = "編集権限がありません"
    end
  end

  def no_user_show_when_user_deleted
    @user = User.find(params[:id])
    if @user.deleted_user?
      redirect_to request.referer
      flash[:danger] = "退会済みユーザーの詳細ページは見ることができません"
    end
  end
end
