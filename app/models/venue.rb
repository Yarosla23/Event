class Venue < ApplicationRecord
  belongs_to :user

  has_one :price, dependent: :destroy
  has_one :policy, dependent: :destroy
  has_one :location, dependent: :destroy
  has_one :information, dependent: :destroy
  has_one :facility, dependent: :destroy
  has_one :service, dependent: :destroy
  has_one :rental_info, dependent: :destroy

  has_many :amenities, dependent: :destroy
  has_many :event_types, dependent: :destroy
  has_many :reviews, dependent: :destroy
  
  accepts_nested_attributes_for :price, :policy,
     :location, :amenities, :event_types, 
     :reviews, :information, 
     :rental_info, :facility, :service,
     allow_destroy: true

  
  TYPES = [
    'Офис', 'Зал для мероприятий', 'Конференц-зал', 'Тренажерный зал', 
    'Коворкинг', 'Выставочный зал', 'Аудитория', 'Лофт', 'Скворечник', 
    'Терраса', 'Летняя площадка', 'Ресторанный зал', 'Бар', 'Ресторан', 
    'Кинотеатр', 'Театр', 'Клуб', 'Концертный зал', 'Скейт-парк', 
    'Площадка для мероприятий на открытом воздухе', 'Арт-пространство', 
    'Спортивный комплекс', 'Творческая студия', 'Кино- и фотостудия', 
    'Музей', 'Центр для мастер-классов', 'Выставочное пространство', 
    'Стадион', 'Вилла', 'Отель', 'База отдыха', 'Хостел'
  ]
  

  validates :name, :venue_type, :description, :address, :phone, :email, presence: true
  validates :area, :max_participants, numericality: { only_integer: true, greater_than: 0, message: "должна быть числом больше 0 " }
  validates :phone, format: { with: /\A\+?[0-9]+\z/, message: "должен содержать только цифры" }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validate :venue_type_must_be_valid

  def venue_type_must_be_valid
    invalid_venue_type =  Array(venue_type) - TYPES
    if invalid_venue_type.any?
      errors.add(:venue_type, "#{invalid_venue_type.join(', ')} значения нет в списке")
    end
  end

  def average_rating
    reviews.average(:rating)&.round(2) || 0
  end
end
