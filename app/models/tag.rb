class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :posts, through: :post_tags

  validates :name, presence: true, uniqueness: true, length: { maximum: 15 }

  def self.looks(content)
    tags = Tag.where("name LIKE ?", "%#{content}%")
    # 一つずつ取得し、後ろの計算をしてまた一つ取得、計算を繰り返す
    return tags.inject(init = []) { |result, tag| result + tag.posts }
  end

end
