class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :notifications, dependent: :destroy

  validates :message, length: { minimum: 1, maximum: 100 }

  paginates_per 30

  def create_notification_chat(current_user)
    search_other_user_room = UserRoom.where(room_id: room_id).where.not(user_id: current_user.id)
    other_user = search_other_user_room.find_by(room_id: room.id)
    notification = current_user.active_notifications.new(room_id: room.id,
                                                         chat_id: id,
                                                         visited_id: other_user.user.id,
                                                         visitor_id: current_user.id,
                                                         action: 'chat')
    if notification.me_visited?
      notification.checked = true
    end
    notification.save if notification.valid?
    debugger
  end



end
