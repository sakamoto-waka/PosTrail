class Room < ApplicationRecord
  has_many :users, through: :user_rooms
  has_many :chats, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  
  def create_room_users(user, current_user)
    UserRoom.create(user_id: user.id, room_id: id)
    UserRoom.create(user_id: current_user.id, room_id: id)
  end
  
end
