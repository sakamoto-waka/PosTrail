class Post < ApplicationRecord
  # 都道府県用のアソシエーション
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  scope :latest, -> { order(created_at: :desc) }
  scope :search_prefecture, -> (prefecture_id) { where("prefecture_id = ?", prefecture_id) }
  scope :search_trail_place, -> (trail_place) { where("trail_place = ?", trail_place) }

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :trail_image
  has_many :notifications, dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags, dependent: :destroy

  validates :trail_place, length: { maximum: 25 }
  validates :body, presence: true, length: { maximum: 200 }
  validates :prefecture_id, presence: true

  paginates_per 30

  def get_trail_image(width, height)
    trail_image.variant(resize_to_limit: [width, height]).processed
  end

  # 引数で渡されたユーザーがその投稿のlikesの中にexists?かチェック
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end

  # 通知用メソッド
  def create_notification_like(current_user)
    # 既にいいねされてるか検索(何度も同じ人から通知が来ないようにするため)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ?", current_user.id, self.user_id, id, 'like'])
    # いいねされてない時のみ通知レコード作成
    if temp.blank?
      # postに付くメソッドなのでここのidはpostが持つidとなる
      notification = current_user.active_notifications.new(post_id: id,
                                                           visited_id: user_id,
                                                           action: "like")
      # 自分がした自分へのいいねは通知済みにする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  # 自分以外のコメントしている人をすべて取得→全員に通知を送る(saveはまだ)
  def create_notification_comment(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(post_id: id).
               where.not(user_id: current_user.id).distinct # ←自分と重複を排除
    temp_ids.each do |temp_id|
      save_notification_comment(current_user, comment_id, temp_id[('user_id')])
    end
    # 初コメントなら投稿者にそのまま通知する
    save_notification_comment(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment(current_user, comment_id, visited_id)
    # 通知存在確認はしない→複数回コメントしてもきちんと全て通知される
    notification = current_user.active_notifications.new(post_id: id,
                                                         comment_id: comment_id,
                                                         visited_id: visited_id,
                                                         action: 'comment')
    # 自分の投稿への自分のコメントは通知済みにする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  # タグ用のメソッド
  def save_tag(sent_tags)
    old_tags = PostTag.where("post_id = ?", id)
    old_tags.each do |old_tag|
      old_tag.delete
    end
    # タグをスペース区切りで分割して配列にする＋連続した空白にも対応
    tag_list = sent_tags.split(/[[:blank:]]+/)
    current_tags = tags.pluck(:name) unless tags.nil?
    old_tags = current_tags - tag_list
    new_tags = tag_list - current_tags

    old_tags.each do |old_tag|
      tags.delete
      # tag_idを検索？
      Tag.find_by(name: old_tag)
    end
    # 重複していないタグをtagsの中に代入（保存）
    new_tags.each do |new_tag|
      new_post_tag = Tag.find_or_create_by(name: new_tag)
      tags << new_post_tag
    end
  end

  def self.looks(content)
    prefecture = Prefecture.find_by_name(content)
    prefecture_id = prefecture.id if prefecture.present?
    Post.where("trail_place LIKE ? OR body LIKE ? OR prefecture_id LIKE ?", "%#{content}%", "%#{content}%", "#{prefecture_id}")
  end

  def self.includes_all
    with_attached_trail_image.includes([:tags, :user => { account_image_attachment: :blob }]).latest
  end
  
  def written_by?(current_user)
    user == current_user
  end
  
  def self.search_posts(params)
    if params[:tag_id]
      tag = Tag.find(params[:tag_id])
      tag.posts.includes_all
    elsif params[:trail_place]
      includes_all.search_trail_place(params[:trail_place])
    elsif params[:prefecture_id]
      includes_all.search_prefecture(params[:prefecture_id])
    else
      # includes_allはN+1問題対策
      includes_all
    end
  end
  
end
