class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  before_action :post_find_from_params, only: [:show, :destroy]

  def index
    # 投稿数が多い順に取得する
    tags_list = Tag.find(PostTag.group(:tag_id).order('count(post_id) desc').limit(25).pluck(:tag_id))
    @tags_list = Kaminari.paginate_array(tags_list).page(params[:page]).per(30)
    if params[:tag_id]
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts.page(params[:page]).per(30)
    elsif params[:trail_place]
      @posts = Post.where("trail_place = ?", params[:trail_place])
    else
      @posts = Post.all.page(params[:page]).per(30)
    end
  end

  def tags_index
    @tags = Tag.includes(:posts).sort { |key, val| key.posts.size <=> val.posts.size }
  end

  def show
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to admin_posts_path
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
