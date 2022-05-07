class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy


  validates :name, length: { minimum: 2, maximum: 15 }
  validates :introduction, length: { maximum: 100 }

  def active_for_authentication?
    # is_deletedがfalseならtrueを返すようにする
    super && (is_deleted == false)
  end
  
end
