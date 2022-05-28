class Notification < ApplicationRecord
  belongs_to :post, optional: true # nilを許可する、これがないとbelong_toでnilはエラー
  belongs_to :comment, optional: true
  # デフォルトで最新順にする
  default_scope -> { order(created_at: :desc) }

  belongs_to :visitor, class_name: 'User', optional: true
  belongs_to :visited, class_name: 'User', optional: true
end
