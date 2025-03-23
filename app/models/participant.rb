class Participant < ApplicationRecord
  belongs_to :event

  PARTICIPANT_TYPES = [
    'Для всех возрастов', 'Взрослые', 'Молодые люди от 18-30',
    'Люди с ограниченными возможностями ','Подростки 14-18','Дети 6+','Дети 0+'
]

  validates :min_participants, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :max_participants, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: :min_participants }
  validates :participant_type, presence: true, inclusion: { in:  PARTICIPANT_TYPES, message: "%{value} не является значением из списка" }
  validates :is_private, inclusion: { in: [true, false] }
  validates :is_paid, inclusion: { in: [true, false] }
end