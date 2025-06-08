class Event < ApplicationRecord
  include PgSearch::Model

  belongs_to :user
  
  has_one :participant, dependent: :destroy
  has_one :logistic, dependent: :destroy
  has_one :event_rule, dependent: :destroy
  
  has_many :tickets, dependent: :destroy
  has_many :event_photos, dependent: :destroy
  has_many :reviews, as: :reviewable, dependent: :destroy

  accepts_nested_attributes_for :event_photos, :participant,
    :logistic,:tickets, :event_rule, 
    allow_destroy: true

  # Настройка поиска
  pg_search_scope :search_by_all,
    against: {
      name: 'A',
      description: 'B',
      location: 'C'
    },
    using: {
      tsearch: { prefix: true }
    }

  pg_search_scope :search_by_tags,
    against: :tags,
    using: {
      tsearch: { prefix: true }
    }

  TYPES = [
    "Поход в спортзал", "Настольные игры", "Тур",
    "Прогулка", "Вечеринки", "Квартирник",
    "Поэтический вечер", "Караоке вечер", "Просмотр фильмов",
    "Быстрые свидания", "Найти друга/подругу/компанию", "Ролевые игры",
    "Музыкальные мероприятия (концерты, конкурсы)", "Косплей-вечеринки", "Стендап",
    "Йога", "Медитация", "Тик-ток вечер",
    "Танцы", "Экскурсии", "Походы",
    "Встречи без слов", "Вечер у костра", "Волонтерские мероприятия",
    "Вечер мам"
  ]

  validates :user_id, :name, :start_time, :end_time, :location, presence: true

  validates :tags, presence: true
  validate :tags_must_be_valid
  
  validates :name, length: { maximum: 100 }
  validates :description, length: { maximum: 2000 }, allow_nil: true
  validates :location, length: { maximum: 255 }, allow_nil: true
  validates :location_link, format: { with: URI::DEFAULT_PARSER.make_regexp, message: "должна быть ссылка" }, allow_blank: true

  validates :event_format, length: { maximum: 100 }, allow_nil: true

  validate :start_time_before_end_time

  def average_rating
    reviews.average(:rating)&.round(2) 
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[name description location start_time end_time created_at updated_at tags event_format]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[participant tickets]
  end

  private
  def tags_must_be_valid
    invalid_tags = tags - TYPES
    if invalid_tags.any?
      errors.add(:tags, "#{invalid_tags.join(', ')} значения нет в списке")
    end
  end

  def start_time_before_end_time
    if start_time && end_time && start_time >= end_time
      errors.add(:start_time, "must be before end time")
    end
  end
end
