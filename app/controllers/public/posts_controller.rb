class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :no_post_when_user_deleted, only: [:show]

  def index
    tags_list = Tag.find(PostTag.group(:tag_id).order('count(tag_id) desc').limit(25).pluck(:tag_id))
    @tags_list = Kaminari.paginate_array(tags_list).page(params[:page]).per(10)
    if params[:tag_id]
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts.page(params[:page]).per(20)
    else
      @posts = Post.all
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      @post.save_tag(params[:post][:tag])
      redirect_to post_path(@post)
      flash[:success] = "投稿しました"
    else
      @posts = Post.all
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
  end

  def update
    if @post.update(post_params)
      old_tags = PostTag.where("post_id = ?", @post.id)
      old_tags.each do |old_tag|
        old_tag.delete
      end
      @post.save_tag(params[:post][:tag])
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
    # url直打ち対策
    def no_post_when_user_deleted
      @post = Post.find(params[:id])
      redirect_to posts_path if @post.user.is_deleted == true
    end

    def ensure_correct_user
      @post = Post.find(params[:id])
      redirect_to post_path(@post) if @post.user != current_user
    end
end
