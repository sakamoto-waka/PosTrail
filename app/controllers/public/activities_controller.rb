class Public::ActivitiesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @activities = current_user.active_notifications.page(params[:page]).per(20)
  end
end
