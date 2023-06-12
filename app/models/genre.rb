class Genre < ApplicationRecord
  has_many :items

  scope :only_active, -> { where(is_active: true) }

  validates :genre_name, presence: true, uniqueness: true
end
