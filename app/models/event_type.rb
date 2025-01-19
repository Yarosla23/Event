class EventType < ApplicationRecord
  belongs_to :venue

  validates :name, presence: true
end
