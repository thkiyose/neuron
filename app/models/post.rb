class Post < ApplicationRecord
  belongs_to :contribution
  validates :content, presence: true
end
