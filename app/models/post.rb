class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :trail_image
  has_many :notifications, dependent: :destroy

  validates :body, presence: true, length: { maximum: 200 }

  def get_trail_image(width, height)
    trail_image.variant(resize_to_limit: [width, height]).processed
  end

  # 引数で渡されたユーザーがその投稿のlikesの中にexists?かチェック
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
  
  # 通知用メソッド
  def create_notification_like(current_user)
    # 既にいいねされてるか検索(何度も同じ人から通知が来ないようにするため)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ?", current_user.id, user_id, id, 'like'])
    # いいねされてないなら通知レコード作成
    if temp.blank?
      # postに付くメソッドなのでここのidはpostが持つidとなる
      notification = current_user.active_notifications.new(post_id: id,
                                                             visited_id: user_id,
                                                             action: "like")
      # 自分がした自分へのいいねは通知済みにする
      if notification.visitor_id == notification.visited_id
        notification.checked == true
      end
      notification.save if notification.valid?
    end
  end

end
