class Vote < ApplicationRecord
  belongs_to :option
  belongs_to :user
  validates :option_id, uniqueness: { scope: :user_id }
end
