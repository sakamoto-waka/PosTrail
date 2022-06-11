class Notification < ApplicationRecord
  belongs_to :post, optional: true # nilを許可する、これがないとbelong_toでnilはエラー
  belongs_to :comment, optional: true
  belongs_to :room, optional: true
  belongs_to :chat, optional: true
  
  # 最新順にする
  scope :latest, -> { order(created_at: :desc) }

  belongs_to :visitor, class_name: 'User', optional: true
  belongs_to :visited, class_name: 'User', optional: true
  
  def me_visited?
    visitor_id == visited_id
  end
  
  def my_comment?
    post.user_id == visited.id
  end
  
end
