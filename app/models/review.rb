class Review < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :limit

  belongs_to :user
  has_one_attached :image


  with_options presence: true do
    validates :title, :text, :image
  end
  validates :title, length: { maximum: 15 }
  
  with_options numericality: { other_than: 1 } do
    validates :category_id, :limit_id
  end
  


end
