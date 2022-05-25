class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    # 投稿数が多い順に取得する
    tags_list = Tag.find(PostTag.group(:tag_id).order('count(post_id) desc').limit(25).pluck(:tag_id))
    @tags_list = Kaminari.paginate_array(tags_list).page(params[:page]).per(30)
    if params[:tag_id]
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts.with_attached_trail_image.includes([:user, :tags]).page(params[:page])
    elsif params[:trail_place]
      @posts = Post.where("trail_place = ?", params[:trail_place]).with_attached_trail_image.includes([:user, :tags]).page(params[:page])
    elsif params[:prefecture_id]
      @posts = Post.where("prefecture_id = ?", params[:prefecture_id]).with_attached_trail_image.includes([:user, :tags]).page(params[:page])  
    else
      @posts = Post.with_attached_trail_image.includes([:tags, :user => {account_image_attachment: :blob}]).page(params[:page])
    end
  end

  def tags_index
    @tags = Tag.includes(:posts).sort { |key, val| key.posts.size <=> val.posts.size }
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user).page(params[:page])
  end

  def destroy
    post = Post.find(params[:id])
    post.tags.destroy_all
    post.destroy
    redirect_to admin_posts_path
    flash[:danger] = "投稿を削除しました"
  end

  def tags_index_destroy
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to tags_index_admin_posts_path
    flash[:danger] = "'#{tag.name}'タグを消去しました"
  end


end
