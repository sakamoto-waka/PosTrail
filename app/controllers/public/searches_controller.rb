class Public::SearchesController < ApplicationController

  def search
    @content = params[:content]
    @posts = Post.with_attached_trail_image.includes([:tags, :user => { account_image_attachment: :blob }]).looks(@content).page(params[:page]).per(20)
    @users = User.with_attached_account_image.looks(@content).where("is_deleted = ?", false).page(params[:page]).per(10)
    tags = Tag.includes([:posts => { trail_image_attachment: :blob }]).looks(@content)
    @tags = Kaminari.paginate_array(tags).page(params[:page]).per(10)
  end

end
