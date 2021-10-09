class Comment < ApplicationRecord
  belongs_to :user_id
  belongs_to :recipe_id
  
  validates :comment, presence: true
end
