class Option < ApplicationRecord
  belongs_to :que
  has_many :votes, dependent: :destroy
  validates :option_name, length: { maximum: 30 }, presence: true
end
