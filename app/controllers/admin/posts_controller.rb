class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :post_find_from_params, only: [:show, :destroy]
  
  def index
    @posts = Post.all
  end
  
  def show
  end
  
  def destroy
    @post.destroy
    redirect_to request.referer
  end
  
end
