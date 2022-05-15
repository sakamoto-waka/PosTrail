class Public::CommentsController < ApplicationController
  before_action :authenticate_user!, only: :create
  before_action :ensure_correct_user, only: :destroy


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
      @post = Post.find(params[:post_id])
      @comments = @post.comments
      # 非同期化時に変更
      render "public/posts/show"
    end
  end

  def destroy
    @comment.destroy
    @post = Post.find(params[:post_id])
    @comments = @post.comments.page(params[:page])
    render "public/posts/show"
    admin_signed_in? ? flash[:danger] = "コメントを削除しました" : flash[:info] = "コメントを削除しました"
  end

  private

    def ensure_correct_user
      @comment = Comment.find(params[:id])
      unless @comment.post.user == current_user || admin_signed_in?
        redirect_to post_path("comment_id = ?", @comment.id)
      end
    end

    def comment_params
      params.require(:comment).permit(:comment)
    end

end
