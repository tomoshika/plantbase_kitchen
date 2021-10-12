class Recipe < ApplicationRecord
  attachment :recipe_image
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :foods, dependent: :destroy
  has_many :steps, dependent: :destroy
  accepts_nested_attributes_for :foods, :steps, allow_destroy: true
  #recipeとネストさせて3つのテーブルのデータを同時に保存できるように処理
  
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
  #userがlikesテーブルに既に存在しているか確かめるメソッド

end
