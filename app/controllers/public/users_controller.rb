class Public::UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update]
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
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
    @like_posts = Post.find(likes)
  end
  
  private
    # user_paramsはapplication_controllerにあり
    
    def ensure_correct_user
      @user = User.find(params[:id])
      redirect_to user_path(@user) if @user != current_user
    end
  
end
