class Public::ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_mutual_follow, only: :show

  def show
    # @user = User.find(params[:id])
    room_ids = current_user.user_rooms.pluck(:room_id)
    # ↑配列で取得されたものに↓最初にマッチしたUserRoomを取得
    user_room = UserRoom.find_by(user_id: @user.id, room_id: room_ids)

    if user_room.blank?
      @room = Room.new
      @room.save
      @room.create_room_users(@user, current_user)
    else
      @room = user_room.room
    end
    @chats = @room.chats.includes(:user).order(created_at: :desc).page(params[:page])
    @chat = Chat.new(room_id: @room.id, user_id: @user.id)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
    @chat.create_notification_chat()
    user_room = UserRoom.find_by(user_id: @chat.user_id, room_id: @chat.room_id)
    @chats = user_room.room.chats.includes(:user).order(created_at: :desc).page(params[:page])
  end

  private
  
    def ensure_mutual_follow
      @user = User.find(params[:id])
      unless @user.following?(current_user)
        redirect_to users_path
        flash[:danger] = "相互フォローの方のみとDMできます"
      end
    end

    def chat_params
      params.require(:chat).permit(:message, :room_id)
    end

end
