class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review, foreign_key: :review_id, dependent: :destroy

  validates :comment, presence: true, length: {maximum: 50 } 
end
