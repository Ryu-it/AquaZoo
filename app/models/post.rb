class Post < ApplicationRecord
  has_one_attached :image

  validates :title, presence: true

  belongs_to :user
  belongs_to :category
  belongs_to :area

  def self.ransackable_attributes(auth_object = nil)
    [ "title", "body", "name", "area_id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[ area user category ]
  end
end
