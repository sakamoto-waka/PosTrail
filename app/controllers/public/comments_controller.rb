class Public::CommentsController < ApplicationController
  before_action :authenticate_user! && :authenticate_admin!
  
  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      # 通知として保存
      @post.create_notification_comment(current_user, @comment.id)
      flash.now[:success] = "コメントを送信しました"
      redirect_to @post
    else
      # 非同期化時に変更
      redirect_to post_path(@post)
    end
  end
  
  def destroy
    Comment.find(params[:id]).destroy
    @post = Post.find(params[:post_id])
    redirect_to @post
  end
  
  private
  
    def comment_params
      params.require(:comment).permit(:comment)
    end
  
end
