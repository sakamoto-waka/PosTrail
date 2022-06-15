class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :notifications, dependent: :destroy

  validates :comment, length: { minimum: 1, maximum: 100 }

  paginates_per 25

  def includes_user(page)
    includes([:user => { account_image_attachment: :blob }]).page(page)
  end
end
