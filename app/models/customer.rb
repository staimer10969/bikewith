class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  #自分からの通知
  has_many :active_notices, class_name: 'Notice', foreign_key: 'visitor_id', dependent: :destroy
  #相手からの通知
  has_many :passive_notices, class_name: 'Notice', foreign_key: 'visited_id', dependent: :destroy
  has_one_attached :image

  enum skill:{beginner:0, intermediate:1, advanced:2, professional:3}
  enum frequency:{several_times:0, more_than_once:1, every_day:2}

  validates :name, presence: true

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'no_image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [250, 250]).processed
  end

end
