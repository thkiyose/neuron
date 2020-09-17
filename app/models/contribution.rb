class Contribution < ApplicationRecord
  belongs_to :user
  has_one :post, dependent: :destroy
end
