class Event < ApplicationRecord
  belongs_to :user
  
  has_one :participant, dependent: :destroy
  has_one :logistic, dependent: :destroy
  has_one :event_rule, dependent: :destroy
  
  has_many :tickets, dependent: :destroy
  has_many :event_photos, dependent: :destroy
  
  accepts_nested_attributes_for :event_photos, :participant,
    :logistic,:tickets, :event_rule, 
    allow_destroy: true

  TYPES = [
    'Вебинар', 'Лекция', 'Семинар', 'Тренинг', 'Воркшоп', 'Мастер-класс', 
    'Конференция', 'Форум', 'Круглый стол', 'Панельная дискуссия', 'Презентация', 'Нетворкинг', 
    'Марафон', 'Хакатон', 'Квест', 'Брейнсторминг', 
    'Фестиваль', 'Концерт', 'Выставка', 
    'Митап', 'Тематическая встреча', 'Челлендж', 
    'Мотивационные встречи', 'Бизнес-игры', 'Тимбилдинг', 
    'Экскурсия', 'Выездная сессия', 'День открытых дверей', 
    'Техническая конференция', 'Техническая выставка', 'Профессиональная конференция', 
    'Международная конференция', 'Международный форум'
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
