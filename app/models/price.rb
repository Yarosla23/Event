class Price < ApplicationRecord
  belongs_to :venue

  validates :amount, :currency, :min_duration, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validates :min_duration, numericality: { only_integer: true, greater_than: 0 }
end
