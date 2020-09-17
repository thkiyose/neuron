class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable
  validates :user_name, presence: true, length: { maximum: 20 }
  has_one :profile, dependent: :destroy
  has_one :contribution, dependent: :destroy
end
