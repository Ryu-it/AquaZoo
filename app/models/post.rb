class Post < ApplicationRecord
  has_one_attached :image

  validates :title, presence: true

  belongs_to :user
  belongs_to :category
  belongs_to :area
end
