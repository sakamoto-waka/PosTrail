class Public::SearchesController < ApplicationController

  def search
    content = params[:content]
    @posts = Post.looks(content).page(params[:page]).per(20)
    @users = User.looks(content).where("is_deleted = ?", false).page(params[:page]).per(10)
    @tags = Tag.looks(content).page(params[:page]).per(20)
  end

end
