class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable
  validates :user_name, presence: true, length: { maximum: 20 }
  has_one :profile, dependent: :destroy
  has_many :contributions, dependent: :destroy
  has_many :active_relationships, foreign_key: "follower_id", class_name: "UserRelation", dependent: :destroy
  has_many :passive_relationships, foreign_key: "followed_id", class_name: "UserRelation", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :favorites, dependent: :destroy
  has_many :favorite_contributions, through: :favorites, source: :contribution

  def follow!(other_user)
    active_relationships.create!(followed_id: other_user.id)
  end

  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def favorited?(contribution)
    favorites.where(contribution_id: contribution.id).exists?
  end
end
