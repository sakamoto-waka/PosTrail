class Public::SearchesController < ApplicationController

  def search
    @content = params[:content]
    @posts = Post.looks(@content).page(params[:page]).per(3)
    @users = User.looks(@content).where("is_deleted = ?", false).page(params[:page]).per(10)
  end

end
