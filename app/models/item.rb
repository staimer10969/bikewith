class Item < ApplicationRecord
  belongs_to :genre
  has_many :mybike_reviews, dependent: :destroy
  has_many :bike_reviews, dependent: :destroy
  has_one_attached :image

  validates :brand, presence: true
  validates :model, presence: true
  validates :model_year, presence: true
  validates :engine, presence: true
  validates :price, presence: true, :numericality => { :greater_than_or_equal_to => 0 }

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [250, 250]).processed
  end

  #scope :where_genre_active, -> { joins(:genre).where(genres: { is_active: true }) }

  def with_tax_price
    (price * 108 / 100.0).ceil
  end

  def self.recommended
    recommends = []
    active_genres = Genre.only_active.includes(:items)
    active_genres.each do |genre|
      item = genre.items.last
      recommends << item if item
    end
    recommends
  end
end
