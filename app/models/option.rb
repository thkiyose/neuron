class Option < ApplicationRecord
  belongs_to :que
  validates :option_name, length: { maximum: 30 }, presence: true
end
