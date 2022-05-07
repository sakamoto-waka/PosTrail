class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :account_image
  
  # フォロー機能用のアソシエーション
  has_many :relationships, foreign_key: 'follower_id', dependent: :destroy
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  # 通知用アソシエーション
  # 自分からの通知
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  # 相手からの通知
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  validates :name, length: { minimum: 2, maximum: 15 }
  validates :introduction, length: { maximum: 100 }

  def active_for_authentication?
    # is_deletedがfalseならtrueを返すようにする
    super && (is_deleted == false)
  end

  def get_account_image(width, height)
    unless account_image.attached?
      file_path = Rails.root.join('app/assets/images/horse_no_image.png')
      account_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    account_image.variant(resize_to_limit: [width, height]).processed
  end
  
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  
  def following?(user)
    followings.include?(user)
  end
  
  def follower?(user)
    followers.include?(user)
  end

end
