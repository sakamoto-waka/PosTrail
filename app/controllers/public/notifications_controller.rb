class Public::NotificationsController < ApplicationController
  def index
    notifications = current_user.passive_notifications
    # 通知を一回したら確認済みに変更
    notifications.where(checked: false).each do |notification|
      notification.update_attribute(:checked, true)
    end
    
    @notifications_except_me = notifications.where.not("visitor_id = ?", current_user.id).page(params[:page]).per(20)
  end
end
