class Public::LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    like = current_user.likes.new(post_id: @post.id)
    like.save
    # redirect_to posts_path
    # 通知として保存
    @post.create_notification_like(current_user)
  end

  def destroy
    @post = Post.find(params[:post_id])
    current_user.likes.find_by(post_id: @post.id).destroy
    # redirect_to posts_path
  end
end
