class RentalInfo < ApplicationRecord
  belongs_to :venue

  # validates :price, :working_hours_start, :working_hours_end, :rules, :disclaimer, presence: true
end
