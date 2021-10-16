class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :image
  has_many :recipes, dependent: :destroy
  has_many :foods, dependent: :destroy
  has_many :steps, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

#フォロー機能のアソシエーション
  #フォローする側からのリレーション
  has_many :relationships, foreign_key: :following_id
  #ユーザーがフォローしている人(follower)を取ってくる
  has_many :followings, through: :relationships, source: :follower
  #フォローされる側からのリレーション
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :follower_id
  #ユーザーをフォローしている人(following)を取ってくる
  has_many :followers, through: :reverse_of_relationships, source: :following

  #フォローされてるかどうか確認するためのメソッド（viewの条件分岐に使用）
  def is_followed_by?(user)
    reverse_of_relationships.find_by(following_id: user.id).present?
  end

  #検索機能の定義
  def self.search(search,word)
    if search == "perfect_match"
    　@user = User.where(name: word)
    elsif search == "partial_match"
    　@user = User.where("name LIKE?","%#{word}%")
    else
    　@user = User.all
    end
  end

end
