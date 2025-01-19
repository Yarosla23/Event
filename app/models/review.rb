class Review < ApplicationRecord
  belongs_to :venue

  validates :content, :rating, presence: true
  validates :rating, inclusion: { in: 1..5, message: "должен быть между 1 и 5" }
end
