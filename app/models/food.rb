class Food < ApplicationRecord
  # validates :item, presence: true
  # validates :quantity, presence: true

  belongs_to :recipe
end
