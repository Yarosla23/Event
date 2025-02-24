class Participant < ApplicationRecord
  belongs_to :event

  PARTICIPANT_TYPES = [
    'Для всех возрастов', 'Только для взрослых','Только для друзей','Только для членов клуба',
    'Для семей с детьми','Только для студентов',
    'Для специалистов', 'Для начинающих','Для опытных','Для стартапов'
]

  validates :min_participants, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
  validates :max_participants, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: :min_participants }
  validates :participant_type, presence: true, inclusion: { in:  PARTICIPANT_TYPES, message: "%{value} is not a valid participant type" }
  validates :is_private, inclusion: { in: [true, false] }
  validates :is_paid, inclusion: { in: [true, false] }
end