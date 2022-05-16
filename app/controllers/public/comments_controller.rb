class Public::CommentsController < ApplicationController
  before_action :authenticate_user!, only: :create
  before_action :ensure_correct_user, only: :destroy


  def create
    @post = Post.find(params[:post_id])
    @comment = current_user.comments.build(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      # 通知として保存
      @post.create_notification_comment(current_user, @comment.id)
      redirect_to @post
      flash[:success] = "コメントを送信しました"
    else
      @post = Post.find(params[:post_id])
      @comments = @post.comments.page(params[:page])
      # 非同期化時に変更
      render "public/posts/show"
    end
  end

  def destroy
    @comment.destroy
    @post = Post.find(params[:post_id])
    @comments = @post.comments.page(params[:page])
    redirect_to request.referer
    admin_signed_in? ? flash[:danger] = "コメントを削除しました" : flash[:info] = "コメントを削除しました"
  end

  private

    def ensure_correct_user
      @post = Post.find(params[:post_id])
      @comment = Comment.find(params[:id])
      unless admin_signed_in? 
        unless (@comment.user_id == current_user.id)
          redirect_to post_path(@post)
        end
      end
    end

    def comment_params
      params.require(:comment).permit(:comment, :post_id)
    end

end
