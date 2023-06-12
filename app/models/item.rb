class Item < ApplicationRecord
  belongs_to :genre
  has_many :mybike_reviews, dependent: :destroy
  has_many :bike_reviews

  validates :brand, presence: true
  validates :model, presence: true
  validates :mode_year, presence: true
  validates :engine, presence: true
  validates :price, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  attachment :image

  scope :where_genre_active, -> { joins(:genre).where(genres: { is_active: true }) }

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
