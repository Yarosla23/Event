class Event < ApplicationRecord
  belongs_to :user

  has_one :participant, dependent: :destroy
  has_one :logistic, dependent: :destroy
  has_many :tickets, dependent: :destroy

  accepts_nested_attributes_for :participant, allow_destroy: true
  accepts_nested_attributes_for :logistic, allow_destroy: true
  accepts_nested_attributes_for :tickets, allow_destroy: true

  validates :user_id, :name, :start_time, :end_time, :location, presence: true
 
  validates :name, length: { maximum: 100 }
  validates :description, length: { maximum: 360 }, allow_nil: true
  validates :event_type, length: { maximum: 100 }, allow_nil: true
  validates :location, length: { maximum: 255 }, allow_nil: true
  validates :location_link, length: { maximum: 255 }, allow_nil: true
  validates :event_format, length: { maximum: 100 }, allow_nil: true

  validate :start_time_before_end_time

  private

  def start_time_before_end_time
    if start_time && end_time && start_time >= end_time
      errors.add(:start_time, "must be before end time")
    end
  end
end
