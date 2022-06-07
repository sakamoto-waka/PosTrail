class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :message, length: { minimum: 1, maximum: 100 }
end
