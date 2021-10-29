class Recipe < ApplicationRecord
  attachment :recipe_image

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :foods, dependent: :destroy
  has_many :steps, dependent: :destroy
  # recipeとネストさせて3つのテーブルのデータを同時に保存できるように処理
  accepts_nested_attributes_for :foods, :steps, allow_destroy: true
  has_many :hashtag_relations
  has_many :hashtags, through: :hashtag_relations

  validates :title, presence: true
  validates :recipe_image, presence: true
  validates :comments, associated: true

  # userがlikesテーブルに既に存在しているか確かめるメソッド
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  # 検索機能の定義
  def self.search(search, word)
    if search == "perfect_match"
      @recipe = Recipe.where("title LIKE?", "#{word}")
    elsif search == "partial_match"
      @recipe = Recipe.where("title LIKE?", "%#{word}%")
    else
      @recipe = Recipe.all
    end
  end

  # レシピ投稿時、タグの保存のためDBへcommitした後に実践する処理
  after_create do
    recipe = Recipe.find_by(id: self.id)
    hashtags = self.memo.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    recipe.hashtags = []
    hashtags.uniq.map do |hashtag|
      # ハッシュタグは'#'なしで保存（downcaseで小文字に変換）
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      recipe.hashtags << tag
    end
  end

  # レシピ更新時、タグの保存のためDBへcommitする前に実践する処理
  before_update do
    recipe = Recipe.find_by(id: self.id)
    recipe.hashtags.clear
    hashtags = self.memo.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      recipe.hashtags << tag
    end
  end
  # hashtagsのヘルパーメソッドはhelpers/recipes_helper.rbに記述
end
