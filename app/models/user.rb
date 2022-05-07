class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_one_attached :account_image


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

end
