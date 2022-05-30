class Public::SearchesController < ApplicationController
  def search
    @content = params[:content]
    @posts = Post.includes_all.latest.joins(:user).where(user: { is_deleted: false }).looks(@content).page(params[:page]).per(25)
    @users = User.looks(@content).where("is_deleted = ?", false).page(params[:page]).per(25)
    tags = Tag.includes([:posts => { trail_image_attachment: :blob }]).looks(@content)
    @tags = Kaminari.paginate_array(tags).page(params[:page]).per(25)
  end
end
