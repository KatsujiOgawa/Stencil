class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review, foreign_key: :review_id, dependent: :destroy
end
