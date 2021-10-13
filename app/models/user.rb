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
  has_many :relationships, foreign_key: :following_id
  #フォローする側からのリレーション
  has_many :followings, through: :relationships, source: :follower
  #ユーザーがフォローしている人(follower)を取ってくる
  
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :follower_id
  #フォローされる側からのリレーション
  has_many :followers, through: :reverse_of_relationships, source: :following
  #ユーザーをフォローしている人(following)を取ってくる

  def is_followed_by?(user)
    reverse_of_relationships.find_by(following_id: user.id).present?
  end
  #フォローされてるかどうか確認するためのメソッド（viewの条件分岐に）

end
