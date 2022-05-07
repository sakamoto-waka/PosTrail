class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :trail_image

  validates :body, presence: true, length: { maximum: 200 }

  def get_trail_image(width, height)
    trail_image.variant(resize_to_limit: [width, height]).processed
  end

  # 引数で渡されたユーザーがその投稿のlikesの中にexists?かチェック
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

end
