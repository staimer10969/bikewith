class Genre < ApplicationRecord
  has_many :items

  validates :genre_name, presence: true, uniqueness: true
end
