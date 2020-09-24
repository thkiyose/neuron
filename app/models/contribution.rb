class Contribution < ApplicationRecord
  belongs_to :user
  has_one :post, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  scope :self_contributions, -> (current_user_id){ where(user_id: current_user_id) }
end
