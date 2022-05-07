class Public::CommentsController < ApplicationController
  
  def create
    @post = Post.find(params[:book_id])
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = @post.id
    if @comment.save
      flash.now[:success] = "コメントを送信しました"
      redirect_to @post
    else
      render @post
    end
  end
  
  def destroy
    
  end
  
  private
  
    def comment_params
      params.require(:comment).permit(:comment)
    end
  
end
