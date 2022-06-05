class Question < ApplicationRecord
  belongs_to :user

  validates :content, length: { minimum: 2, maximum: 250 }
  validates :title, length: { minimum: 2, maximum: 50 }
  validates :riding_experience, length: { minimum: 2, maximum: 20 }

  enum category: { beginner: 0, intermediate: 1, advanced: 2 }
end
