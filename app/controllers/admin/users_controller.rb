class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :user_find_from_params
  
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user)
      flash[:success] = "#{@user.name}さんのユーザー情報を更新しました"
    else
      render :edit
    end
  end
  
end
