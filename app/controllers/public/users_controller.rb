class Public::UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @users = User.with_attached_account_image
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.with_attached_trail_image.includes([:tags]).page(params[:page]).per(30)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
      flash[:success] = "ユーザー情報を更新しました"
    else
      render :edit
    end
  end

  def likes
    @user = User.find(params[:id])
    likes = Like.where("user_id = ?", @user.id).pluck(:post_id)
    @like_posts = Post.with_attached_trail_image.includes([:user, :tags]).find(likes)
  end

  private
    # user_paramsはapplication_controllerにあり
    def ensure_correct_user
      @user = User.find(params[:id])
      if @user != current_user || @user.name == "ゲストユーザー"
        redirect_to user_path(@user)
        flash[:danger] = "編集権限がありません"
      end
    end

end
