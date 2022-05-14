class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :post_find_from_params, only: [:show, :destroy]

  def index
    tags_list = Tag.find(PostTag.group(:tag_id).order('count(post_id) desc').limit(25).pluck(:tag_id))
    @tags_list = Kaminari.paginate_array(tags_list).page(params[:page]).per(10)
    @posts = Post.all
  end

  def tags_index
    @tags = Tag.includes(:posts).sort { |key, val| key.posts.size <=> val.posts.size }
  end

  def show
  end

  def destroy
    @post.destroy
    redirect_to request.referer
    flash[:danger] = "投稿を削除しました"
  end

  def tags_list_destroy
    tag = Tag.find(params[:id])
    tag.destroy
    redirect_to tags_index_admin_posts_path
    flash[:danger] = "'#{tag.name}'タグを消去しました"
  end

  private

    def post_find_from_params
      @post = Post.find(params[:id])
    end

end
