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
  has_many :relationships, foreign_key: :follower_id
  has_many :followers, through: :relationships, source: :followed
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :followed_id
  has_many :followeds, through: :reverse_of_relationships, source: :follower

  # def is_followed_by?(user)
  #   reverse_of_relationships.find_by(follower_id: user.id).present?
  # end

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followeds.include?(user)
  end

end
