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
    # いいねされてない時のみ通知レコード作成
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
    
    # 自分以外のコメントしている人をすべて取得→全員に通知を送る(saveはまだ)
    def create_notification_comment(current_user, comment_id)
      temp_ids = Comment.select(:user_id).where(post_id: id)
                                         .where.not(user_id: current_user.id).distinct #←自分と重複を排除
      temp_ids.each do |temp_id|
        save_notification_comment(current_user, comment_id, temp_id[('user_id')])
      end
      # 初コメントなら投稿者にそのまま通知する
      save_notification_comment(current_user, comment_id, user_id) if temp_ids.blank?
    end
      
    def save_notification_comment(current_user, comment_id, visited_id)  
      # 通知存在確認はしない→複数回コメントしてもきちんと全て通知される
      notification = current_user.active_notifications.new(post_id: id,
                                                           comment_id: comment_id,
                                                           visited_id: visited_id,
                                                           action: 'comment')
      # 自分の投稿への自分のコメントは通知済みにする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
      
  end

end
