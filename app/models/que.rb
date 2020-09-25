class Que < ApplicationRecord
  belongs_to :contribution
  validates :question, length: { maximum: 500 }, presence: true
  enum que_type: %i(選択肢　自由回答)
end
