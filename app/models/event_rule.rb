class EventRule < ApplicationRecord
  belongs_to :event

  validates :rules, presence: true
  # validates :consent, acceptance: { message: 'You must agree to the rules.' }
end
