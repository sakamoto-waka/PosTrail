class Public::PostsController < ApplicationController
  before_action :ensure_user, only: [:edit, :update]
  
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end
  
  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to post_path(@post), flash[:success] = "投稿しました"
    else
      @posts = Post.all
      render :index
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end
  
  def update
    if @post.update(post_params)
      redirect_to post_path(@post), flash[:success] = "投稿内容を更新しました"
    else
      render :edit
    end
  end
  
  private
    def post_params
      params.require(:posts).permit(:body, :trail_place)
    end
    
    def ensure_correct_user
      @post = Post.find(params[:id])
      redirect_to root_path if @post.user != current_user
    end
end
