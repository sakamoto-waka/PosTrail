class Public::ChatsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    room_ids = current_user.user_rooms.pluck(:room_id)
    # ↑配列で取得されたものに↓最初にマッチしたUserRoomを取得
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: room_ids)

    if user_rooms.blank?
      @room = Room.new
      @room.save
      UserRoom.create(user_id: @user.id, room_id: @room.id)
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
    else
      @room = user_rooms.room
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
  end

  private

    def chat_params
      params.require(:chats).permit(:message, :room_id)
    end

end
