class Review < ApplicationRecord
  belongs_to :customer
  belongs_to :item
  has_one_attached :image

  has_many :comments, dependent: :destroy
  has_many :review_tags, dependent: :destroy
  has_many :tags, through: :review_tags

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [250, 250]).processed
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

  def save_reviewtags(tags)
  # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.reviewtags.pluck(:name) unless self.reviewtags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = tags - current_tags

    # 古いタグを消す
    old_tags.each do |old_name|
      self.reviewtags.delete ReviewTag.find_by(name:old_name)
    end

    # 新しいタグを保存
    new_tags.each do |new_name|
      reviewtag = ReviewTag.find_or_create_by(name:new_name)
      self.reviewtags << reviewtag
    end
  end

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

end
