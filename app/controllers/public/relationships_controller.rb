class Public::RelationshipsController < ApplicationController
  before_action :authenticate_user!, except: [:followers, :followings]

  def create
    @user = User.find(params[:user_id])
    current_user.follow(params[:user_id])
    @user.create_notification_follow(current_user)
    # redirect_to request.referer
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(params[:user_id])
    # redirect_to request.referer
  end

  # フォロー/フォロワーの一覧
  def followings
    @user = User.find(params[:user_id])
  end

end
