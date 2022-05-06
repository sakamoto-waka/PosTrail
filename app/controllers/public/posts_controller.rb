class Public::PostsController < ApplicationController
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end
  
  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to post_path(@post)
      flash[:success] = "投稿しました"
    else
      @posts = Post.all
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end
  
  def update
    if @post.update(post_params)
      redirect_to post_path(@post)
      flash[:success] = "投稿内容を更新しました"
    else
      render :edit
    end
  end
  
  
  def destroy
    @post.destroy
    redirect_to request.referer
  end
  
  private
  
    def ensure_correct_user
      @post = Post.find(params[:id])
      redirect_to post_path(@post) if @post.user != current_user
    end
end
