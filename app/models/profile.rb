class Profile < ApplicationRecord
  belongs_to :users
  validates :screen_name, length: { maximum: 20 }, presence: true
            :introduction, length: { maximum: 300 }
end
