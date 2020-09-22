class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable
  validates :user_name, presence: true, length: { maximum: 20 }
  has_one :profile, dependent: :destroy
  has_many :contributions, dependent: :destroy
  has_many :active_relationships, foreign_key: "follower_id", class_name: "User_relation", dependent: :destroy
  has_many :passive_relationships, foreign_key: "followed_id", class_name: "User_relation", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
end
