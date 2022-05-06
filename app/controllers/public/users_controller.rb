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
    @user.update(user_params)
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :introduction)
    end
  
    def ensure_correct_user
      @user = User.find(params[:id])
      redirect_to user_path(@user) if @user != current_user
    end
  
end
