class Review < ApplicationRecord
  belongs_to :venue
  belongs_to :user

  validates :content, presence: true, length: { maximum: 1000 }
  validates :rating, presence: true, inclusion: { in: 1..5 } 
end
