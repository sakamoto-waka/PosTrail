class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user

  def show
    @user = User.find(params[:id])
    @posts = @user.includes_all.page(params[:page]).per(30)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      @user.change_name_when_deleted
      redirect_to admin_user_path(@user)
      flash[:success] = "#{@user.name}さんのユーザー情報を更新しました"
    else
      render :edit
    end
  end
end
