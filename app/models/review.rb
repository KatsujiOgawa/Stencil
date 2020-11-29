class Review < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :limit

  belongs_to :user
  has_many :comments, foreign_key: :review_id, dependent: :destroy
  has_one_attached :image


  with_options presence: true do
    validates :title, :text, :image
  end
  validates :title, length: { maximum: 20 }
  validates :text, length: { maximum: 2000 }
  
  with_options numericality: { other_than: 1 , message: "isn't selected"} do
    validates :category_id, :limit_id
  end
  


end
