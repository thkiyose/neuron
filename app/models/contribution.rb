class Contribution < ApplicationRecord
  belongs_to :user
  has_one :post, dependent: :destroy
  has_one :que, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user
  has_many :comments, dependent: :destroy

  scope :self_contributions, -> (current_user_id){ where(user_id: current_user_id) }
end
