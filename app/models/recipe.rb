class Recipe < ApplicationRecord
  attachment :recipe_image
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :foods, dependent: :destroy
  has_many :steps, dependent: :destroy
  accepts_nested_attributes_for :foods, :steps, allow_destroy: true

end
