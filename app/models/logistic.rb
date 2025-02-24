class Logistic < ApplicationRecord
  belongs_to :event

  validates :organizers, presence: true
  validates :contact_info, presence: true
  validates :technical_requirements, presence: true
  validates :special_instructions, presence: true
end