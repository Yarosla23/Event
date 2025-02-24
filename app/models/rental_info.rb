class RentalInfo < ApplicationRecord
  belongs_to :venue
  TYPES = [
    'Предоплата', 'Залог', 'Наличка', 'СБП'
  ]
  
  validates :price, :working_hours_start, :working_hours_end, presence: true

end
