# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :user_state, only: :create

  def after_sign_in_path_for(resource)
    posts_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end
  
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to posts_path
    flash[:notice] = "ゲストユーザーでログインしました"
  end

  protected

    def user_state
      @user = User.find_by(email: params[:user][:email])
      return if !@user
      if @user.valid_password?(params[:user][:password]) && @user.is_deleted
        flash[:danger] = "問題があったためアカウントは削除されました"
        redirect_to new_user_registration_path
      end
    end
end
