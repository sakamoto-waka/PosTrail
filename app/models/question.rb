class Question < ApplicationRecord
  belongs_to :user

  validates :title, length: { minimum: 2, maximum: 30 }
  validates :riding_experience, length: { maximum: 10 }
  validates :content, length: { minimum: 2, maximum: 250 }
  validates :answer, length: { maximum: 250 }

  enum category: { beginner: 0, intermediate: 1, advanced: 2 }

  scope :question_latest, -> { order(created_at: :desc) }

  paginates_per 25

end
