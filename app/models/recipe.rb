class Recipe < ApplicationRecord
  attachment :recipe_image
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :foods, dependent: :destroy
  has_many :steps, dependent: :destroy
  #recipeとネストさせて3つのテーブルのデータを同時に保存できるように処理
  accepts_nested_attributes_for :foods, :steps, allow_destroy: true

  #userがlikesテーブルに既に存在しているか確かめるメソッド
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end


  #検索機能の定義
  def self.search(search, word)
    if search == "perfect_match"
      @recipe = Recipe.where("title LIKE?","#{word}")
    elsif search == "partial_match"
      @recipe = Recipe.where("title LIKE?","%#{word}%")
    else
      @recipe = Recipe.all
    end
  end

end
