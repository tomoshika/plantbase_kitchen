class HashtagRelation < ApplicationRecord
  
  belongs_to :recipe
  belongs_to :hashtag
  with_options presence: true do
    validates :recipe_id
    validates :hashtag_id
  end
  
end
