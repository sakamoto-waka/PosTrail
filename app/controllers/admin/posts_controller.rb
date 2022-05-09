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
  end
  
  def tags_list_destroy
    # debugger
    tag = Tag.find(params[:id])
    tag.destroy 
    flash[:success] = "タグを消去しました"
    redirect_to tags_list_admin_posts_path
  end
  
  private
  
    def post_find_from_params
      @post = Post.find(params[:id])
    end

end
