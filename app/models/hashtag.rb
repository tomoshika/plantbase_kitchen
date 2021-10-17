class Hashtag < ApplicationRecord

  has_many :hashtag_relations
  has_many :recipes, through: :hashtag_relations
  validates :hashname, presence: true, length: { maximum:99 }

end
