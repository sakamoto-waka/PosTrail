class Public::CommentsController < ApplicationController
  before_action :authenticate_user!, only: :create
  before_action :ensure_correct_user, only: :destroy


  def create
    @post = Post.find(params[:post_id])
    @comments = @post.comments.page(params[:page])
    @comment = current_user.comments.build(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      # 通知として保存
      @post.create_notification_comment(current_user, @comment.id)
      flash.now[:success] = "コメントを送信しました"
      # jsファイルをrender
      render :post_comments
    else
      @post = Post.find(params[:post_id])
      render :post_comments
    end
  end

  def destroy
    @comment.destroy
    @post = Post.find(params[:post_id])
    @comments = @post.comments.page(params[:page])
    flash.now[:danger] = "コメントを削除しました"
    render :post_comments
  end

  private
    
    def ensure_correct_user
      unless admin_signed_in?
        @post = Post.find(params[:post_id])
        @comment = Comment.find(params[:id])
        unless (@comment.user_id == current_user.id)
          redirect_to post_path(@post)
        end
      end
    end

    def comment_params
      params.require(:comment).permit(:comment, :post_id)
    end

end
