class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_correct_user

  def destroy
    @comment.destroy
    @comments = @post.comments.includes([:user]).page(params[:page])
    flash[:danger] = "コメントを削除しました"
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

end
