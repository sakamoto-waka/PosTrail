class Public::CommentsController < ApplicationController
  before_action :authenticate_user! || admin_signed_in?
  before_action :ensure_correct_user

  
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      # 通知として保存
      @post.create_notification_comment(current_user, @comment.id)
      redirect_to @post
      flash[:success] = "コメントを送信しました"
    else
      # 非同期化時に変更
      redirect_to post_path(@post)
    end
  end
  
  def destroy
    @comment.destroy
    @post = Post.find(params[:post_id])
    redirect_to @post
    flash[:info] = "コメントを削除しました"
  end
  
  private
  
    def ensure_correct_user
      @comment = Comment.find(params[:id]) || admin_signed_in?
      redirect_to post_path("comment_id = ?", @comment.id)
    end
    
    def comment_params
      params.require(:comment).permit(:comment)
    end
  
end
