class Public::SearchesController < ApplicationController

  def search
    content = params[:content]
    # @records = Post.looks(content) && User.looks(content).where("is_deleted = ?", false)

    @posts = Post.looks(content).page(params[:page]).per(3)
    @users = User.looks(content).where("is_deleted = ?", false).page(params[:page]).per(10)

    # if users.present? and posts.present?
    # @records = users + posts
      

      # @records = posts
    # end

    # if User.looks(content).where("is_deleted = ?", false).present?

  end

end
