class Que < ApplicationRecord
  belongs_to :contribution
  has_many :options, dependent: :destroy
  validates :question, length: { maximum: 500 }, presence: true
  enum que_type: %i(options answers)
  accepts_nested_attributes_for :options, allow_destroy: true
end
