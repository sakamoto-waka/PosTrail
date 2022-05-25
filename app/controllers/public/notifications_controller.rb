class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    notifications = current_user.passive_notifications.includes([:visited, :visitor, :post])
    # 通知を一回したら確認済みに変更
    notifications.where(checked: false).each do |notification|
      notification.update_attribute(:checked, true)
    end
    @notifications_except_me = notifications.where.not("visitor_id = ?", current_user.id).limit(25)
    @activities = current_user.active_notifications.includes([:visitor, :post]).limit(20)
  end
end
