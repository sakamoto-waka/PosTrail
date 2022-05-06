class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :user_find_from_params
  
  def show
  end

  def edit
  end
  
  def udpate
    if @user.update(user_params)
      redirect_to admin_user_path(@user)
      flash[:success] = "#{@user.name}さんのユーザー情報を更新しました"
    else
      render :edit
    end
  end
end
