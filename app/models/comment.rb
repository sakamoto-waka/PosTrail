class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :notifications, dependent: :destroy
  
  validates :comment, length: { minimum: 1, maximum: 100}
  
  paginates_per 5
end
