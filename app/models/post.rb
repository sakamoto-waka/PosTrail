class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :trail_image

  validates :body, presence: true, length: { maximum: 200 }
  
  def get_trail_image(width, height)
    trail_image.variant(resize_to_limit: [width, height]).processed
  end
end
