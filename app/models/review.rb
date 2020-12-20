class Review < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :limit

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image


  with_options presence: true do
    validates :title, :text, :image
  end
  validates :title, length: { maximum: 35 }
  validates :text, length: { maximum: 2000 }
  
  with_options numericality: { other_than: 1 , message: "を選択してください"} do
    validates :category_id, :limit_id
  end
  

  def self.search(search)
    if search != "1"
      Review.where(category_id: search)
    else
      Review.all
    end
    
  end


end
