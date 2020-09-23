class Contribution < ApplicationRecord
  belongs_to :user
  has_one :post, dependent: :destroy

  scope :self_contributions, -> (current_user_id){ where(user_id: current_user_id) }
end
