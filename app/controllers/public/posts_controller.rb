class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :no_post_when_user_deleted, only: :show
  before_action :no_guest_post, only: [:new, :post, :edit, :update, :destroy]

  def index
    # 投稿数が多い順に取得する
    tags_list = Tag.find(PostTag.group(:tag_id).order('count(post_id) desc').limit(25).pluck(:tag_id))
    @tags_list = Kaminari.paginate_array(tags_list).page(params[:page]).per(30)
    if params[:tag_id]
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts.page(params[:page])
    elsif params[:trail_place]
      @posts = Post.where("trail_place = ?", params[:trail_place]).page(params[:page])
    elsif params[:prefecture_id]
      @posts = Post.where("prefecture_id = ?", params[:prefecture_id]).page(params[:page])
    else
      @posts = Post.all.page(params[:page])
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
      flash[:notice] = "投稿しました"
    else
      @posts = Post.all
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.page(params[:page])
    @comment = current_user.comments.new
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
    @post.tags.destroy_all
    @post.destroy
    redirect_to request.referer
    flash[:info] = "投稿を削除しました"
  end

  private
    # post_paramsはapplication_controllerに記述
    # url直打ち対策
    def no_post_when_user_deleted
      @post = Post.find(params[:id])
      redirect_to posts_path if @post.user.is_deleted == true
    end

    def ensure_correct_user
      @post = Post.find(params[:id])
      redirect_to post_path(@post) unless (@post.user == current_user) || admin_signed_in? || current_user.name == "ゲストユーザー"
    end

    def no_guest_post
      if current_user.email == "guest@example.com"
        flash[:danger] = "この機能はユーザー登録後に使えます"
        redirect_to request.referer 
      end
    end
end
