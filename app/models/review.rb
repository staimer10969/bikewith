class Review < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  has_one_attached :image

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :review_tags, dependent: :destroy
  has_many :tags, through: :review_tags
  has_many :notices, dependent: :destroy

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [250, 250]).processed
  end

  def liked_by?(customer)
    likes.exists?(customer_id: customer.id)
  end

  def self.sort(sort_select, score, price)
    if score == "" && price == ""
      reviews = includes(:item)
    elsif score == ""
      reviews = includes(:item).where(items: {price: price})
    elsif price == ""
      reviews = includes(:item).where(score: score)
    else
      reviews = includes(:item).where(items: {price: price}).where(score: score)
    end
    case sort_select
      when 'new'
          return reviews.order('reviews.created_at DESC')
      when 'old'
          return reviews.order('reviews.created_at ASC')
      #when 'score'
        #return all.order(Arel.sql('count(post_id) desc').pluck(:review_id))
      when 'price'
          return reviews.order('items.price DESC')
    end
  end

  def save_review_tags(tags)
  # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = tags - current_tags

    # 古いタグを消す
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end

    # 新しいタグを保存
    new_tags.each do |new_name|
      review_tag = Tag.find_or_create_by(name:new_name)
      self.tags << review_tag
    end
  end

  def create_notice_like!(current_customer)
    # すでに「いいね」されているか検索
    temp = Notice.where(["visitor_id = ? and visited_id = ? and review_id = ? and action = ? ", current_customer.id, customer_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notice = current_customer.active_notices.new(
        review_id: id,
        visited_id: customer_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notice.visitor_id == notice.visited_id
        notice.checked = true
      end
      notice.save if notice.valid?
    end
  end

  def create_notice_comment!(current_customer, review_id, id)
    # すでに「いいね」されているか検索
    temp = Notice.where(["visitor_id = ? and visited_id = ? and review_id = ? and comment_id = ? and action = ? ", current_customer.id, review_id, customer_id, id, 'comment'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notice = current_customer.active_notices.new(
        comment_id: id,
        review_id: review_id,
        visited_id: customer_id,
        action: 'comment'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notice.visitor_id == notice.visited_id
        notice.checked = true
      else
        notice.checked = false
      end
      notice.save if notice.valid?
    end
  end

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

end
