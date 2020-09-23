class Post < ApplicationRecord
  belongs_to :contribution
  validates :content, presence: true, length: { maximum: 500 }
end
