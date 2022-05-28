class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @users = User.with_attached_account_image.page(params[:page]).per(20)
  end
end
