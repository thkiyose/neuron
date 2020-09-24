class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :contribution

  validates :content, length: { maximum: 500 }, presence: true
end
