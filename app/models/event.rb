class Event < ApplicationRecord
  belongs_to :user

  has_one :participant, dependent: :destroy
  has_one :logistic, dependent: :destroy
  has_one :event_rule, dependent: :destroy
  
  has_many :tickets, dependent: :destroy
  has_many :event_photos, dependent: :destroy
  
  accepts_nested_attributes_for :event_photos, allow_destroy: true
  accepts_nested_attributes_for :participant, allow_destroy: true
  accepts_nested_attributes_for :logistic, allow_destroy: true
  accepts_nested_attributes_for :tickets, allow_destroy: true
  accepts_nested_attributes_for :event_rule, allow_destroy: true

  TYPES = [
    'Вебинар', 'Конференция', 'Тренинг', 'Семинар', 'Мастер-класс', 'Симпозиум', 'Форум', 
    'Круглый стол', 'Панельная дискуссия', 'Выставка', 'Концерт', 'Митап', 'Фестиваль',
    'Стажировка', 'Мастер-классы', 'Открытые лекции', 'Челленджи', 'Нетворкинг', 'Бизнес-игры',
    'Интервью', 'Тематическая встреча', 'Презентация', 'Выездная сессия', 'Обучение',
    'Мотивационные мероприятия', 'Сетевые встречи', 'Техническая конференция', 'День открытых дверей',
    'Креативные воркшопы', 'Тренинг лидерства', 'HR-саммит', 'Брейнсторминг', 'Производственная конференция',
    'Квесты', 'Онлайн-конференция', 'Турнир', 'Образовательный семинар', 'Воркшоп по инновациям',
    'Марафон', 'Панельная дискуссия по актуальным вопросам', 'Бизнес-семинар', 'Профессиональная конференция',
    'Техническая выставка', 'Презентация нового продукта', 'Публичные лекции', 'Международная конференция',
    'Карьера в бизнесе', 'Экологическая встреча', 'День карьерных консультаций', 'Экспертная сессия'
  ]
  
  validates :user_id, :name, :start_time, :end_time, :location, presence: true

  validates :event_type, presence: true, inclusion: { in:  TYPES, message: "%{value} is not a valid participant type" }
 
  validates :name, length: { maximum: 100 }
  validates :description, length: { maximum: 2000 }, allow_nil: true
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
