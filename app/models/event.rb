class Event < ApplicationRecord
  has_one :participant, dependent: :destroy
  has_one :logistic, dependent: :destroy
  has_many :tickets, dependent: :destroy

  accepts_nested_attributes_for :participant, allow_destroy: true
  accepts_nested_attributes_for :logistic, allow_destroy: true
  accepts_nested_attributes_for :tickets, allow_destroy: true

  validates :name, :start_time, :end_time, presence: true
end
