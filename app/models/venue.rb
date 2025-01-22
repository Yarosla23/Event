class Venue < ApplicationRecord
  has_one :price, dependent: :destroy
  has_one :policy, dependent: :destroy
  has_one :location, dependent: :destroy

  has_many :amenities, dependent: :destroy
  has_many :event_types, dependent: :destroy
  has_many :reviews, dependent: :destroy

  accepts_nested_attributes_for :price, allow_destroy: true
  accepts_nested_attributes_for :policy, allow_destroy: true
  accepts_nested_attributes_for :location, allow_destroy: true
  accepts_nested_attributes_for :amenities, allow_destroy: true
  accepts_nested_attributes_for :event_types, allow_destroy: true
  accepts_nested_attributes_for :reviews, allow_destroy: true
  
  validates :name, :venue_type, :description, :address, :phone, :email, presence: true
  validates :phone, format: { with: /\A\+?[0-9]+\z/, message: "должен содержать только цифры" }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  # Добавляем интеграцию с Google Calendar или другой системой
  # def available_dates
  #   # Логика для обработки доступных дат
  # end
end
