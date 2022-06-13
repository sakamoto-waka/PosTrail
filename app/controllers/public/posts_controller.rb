class Public::PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    # 投稿数が多い順に取得する
    tags_list = Tag.find(PostTag.group(:tag_id).order('count(post_id) desc').limit(25).pluck(:tag_id))
    @tags_list = Kaminari.paginate_array(tags_list).page(params[:page]).per(30)
    # @posts = この先が分からず
    if params[:tag_id]
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts.includes_all.page(params[:page])
    elsif params[:trail_place]
      @posts = Post.includes_all.search_trail_place(params[:trail_place]).page(params[:page])
    elsif params[:prefecture_id]
      @posts = Post.includes_all.search_prefecture(params[:prefecture_id]).page(params[:page])
    else
      # includes_allはN+1問題対策
      @posts = Post.includes_all.page(params[:page])
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      @post.save_tag(params[:post][:tag])
      redirect_to posts_path
      flash[:notice] = "投稿しました"
    else
      @posts = Post.all
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user).order(created_at: :desc).page(params[:page])
    @comment = current_user.comments.new if user_signed_in?
  end

  def edit
  end

  def update
    if @post.update(post_params)
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
    # 投稿詳細から削除した場合とマイページから削除した場合で分ける
    path = Rails.application.routes.recognize_path(request.referer)
    path[:controller] == 'public/posts' ? (redirect_to posts_path) : (redirect_to request.referer)
    flash[:info] = "投稿を削除しました"
  end

  private

    # post_paramsはapplication_controllerに記述
    
    def ensure_correct_user
      @post = Post.find(params[:id])
      redirect_to post_path(@post) unless @post.user == current_user
    end
end
