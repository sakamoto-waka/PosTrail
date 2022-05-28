class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_user

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.with_attached_trail_image.includes([:tags]).page(params[:page]).per(30)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      if @user.is_deleted == true
        @user.update_attribute(:name, "#{@user.name}(退会済み)")
      else
        @user.update_attribute(:name, @user.name.delete('(退会済み)'))
      end
      redirect_to admin_user_path(@user)
      flash[:success] = "#{@user.name}さんのユーザー情報を更新しました"
    else
      render :edit
    end
  end
end
