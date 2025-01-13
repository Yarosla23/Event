class Participant < ApplicationRecord
  belongs_to :event
  
  validates :min_participants, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :max_participants, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: :min_participants }
  validates :participant_type, presence: true, inclusion: { in:  ['Вебинар', 'Конференция', 'Тренинг', 'Семинар'], message: "%{value} is not a valid participant type" }
  validates :is_private, inclusion: { in: [true, false] }
  validates :is_paid, inclusion: { in: [true, false] }
end