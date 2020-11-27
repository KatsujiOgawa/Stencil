class Review < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :limit

  belongs_to :user
  has_one_attached :image
end
