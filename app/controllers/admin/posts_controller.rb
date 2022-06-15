class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    # 投稿数が多い順に取得する
    tags_list = Tag.find(PostTag.group(:tag_id).order('count(post_id) desc').limit(25).pluck(:tag_id))
    @tags_list = Kaminari.paginate_array(tags_list).page(params[:page]).per(30)
    @posts = Post.search_posts(params).page(params[:page])
  end

  def tags_index
    @tags = Tag.includes(:posts).sort { |key, val| key.posts.size <=> val.posts.size }
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes_user(params[:page])
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
